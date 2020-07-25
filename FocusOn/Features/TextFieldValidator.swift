//
//  TextFieldValidator.swift
//  FocusOn
//
//  Created by Gabriel Balta on 23/07/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import Combine

public struct FieldChecker {
    
    public var errorMessage:String?
    
    public var valid:Bool {
         self.errorMessage == nil
     }
    public init( errorMessage:String? = nil ) {
        self.errorMessage = errorMessage
    }
}

public class FieldValidator<T> : ObservableObject where T : Hashable {
    public typealias Validator = (T) -> String?
    
    @Binding private var bindValue:T
    @Binding private var checker:FieldChecker
    
    @Published public var value:T
    {
        willSet {
            self.doValidate(newValue)
        }
        didSet {
            self.bindValue = self.value
        }
    }
    private let validator:Validator
    
    public var isValid:Bool {
        self.checker.valid
    }
    
    public var errorMessage:String? {
        self.checker.errorMessage
    }
    
    public init( _ value:Binding<T>, checker:Binding<FieldChecker>, validator:@escaping Validator  ) {
        self.validator = validator
        self._bindValue = value
        self.value = value.wrappedValue
        self._checker = checker
    }
    
    public func doValidate( _ newValue:T? = nil ) -> Void {
                
        self.checker.errorMessage =
                        (newValue != nil) ?
                            self.validator( newValue! ) :
                            self.validator( self.value )
    }
}

struct TextFieldWithValidator : View {
    // specialize validator for TestField ( T = String )
    typealias Validator = (String) -> String?

    var title:String?

    @ObservedObject var field:FieldValidator<String>

    init( title:String = "", value:Binding<String>,
                           checker:Binding<FieldChecker>,
                         validator:@escaping Validator )
    {
        self.title = title;
        self.field = FieldValidator(value, checker:checker, validator:validator )

    }

    var body: some View {
        VStack {
            TextField( title ?? "", text: $field.value )
                .padding(.all)
                .border( field.isValid ? Color.clear : Color.red )
                .onAppear { self.field.doValidate() } // run validation on appear
                if( !field.isValid  ) {
                    Text( field.errorMessage ?? "" )
                        .fontWeight(.light)
                        .font(.footnote)
                        .foregroundColor(Color.red)
                }
        }
    }
}
