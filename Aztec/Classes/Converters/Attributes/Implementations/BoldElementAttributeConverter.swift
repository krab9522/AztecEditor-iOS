import Foundation
import UIKit

class BoldElementAttributesConverter: ElementAttributeConverter {    

    private let cssAttributeType = CSSAttributeType.fontWeight
    private let cssAttributeValue = FontWeight.bold
    
    func convert(
        _ attribute: Attribute,
        inheriting attributes: [NSAttributedStringKey: Any]) -> [NSAttributedStringKey: Any] {
        
        guard let cssAttribute = attribute.firstCSSAttribute(ofType: cssAttributeType),
            isBold(cssAttribute) else {
                return attributes
        }
        
        var attributes = attributes
        
        // The default font should already be in the attributes.  But in case it's nil
        // we should have some way to figure out the default font.  Honestly it feels like
        // this configuration should come from elsewhere, but we'll just default to the
        // default system font of size 14 for now.
        //
        let font = attributes[.font] as? UIFont ?? UIFont.systemFont(ofSize: 14)
        let newFont = font.modifyTraits([.traitBold], enable: true)
        
        attributes[.font] = newFont
        
        return attributes
    }
    
    private func isBold(_ fontWeightAttribute: CSSAttribute) -> Bool {
        guard let weightValue = fontWeightAttribute.value,
            let weight = Int(weightValue) else {
                return false
        }
        
        return weight >= cssAttributeValue.rawValue
    }
}
