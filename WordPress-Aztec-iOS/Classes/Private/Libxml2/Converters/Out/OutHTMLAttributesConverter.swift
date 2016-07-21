import Foundation
import libxml2

extension Libxml2.Out {
    class AttributesConverter: Converter {

        typealias Attribute = HTML.Attribute
        typealias StringAttribute = HTML.StringAttribute

        /// Converts a linked list of attributes (from libxml2) into an array of our own
        /// representation of attributes.
        ///
        /// - Parameters:
        ///     - attributes: the libxml2 attributes to convert.  This is a linked list.
        ///
        /// - Returns: an array of HTML.Attribute.
        ///
        func convert(attributes: xmlAttrPtr) -> [Attribute] {

            var result = [Attribute]()
            var currentAttributePtr = attributes

            while (currentAttributePtr != nil) {
                let attribute = currentAttributePtr.memory

                let attributeConverter = AttributeConverter()
                result.append(attributeConverter.convert(attribute))
                
                currentAttributePtr = attribute.next
            }
            
            return result
        }
    }
}