import Foundation
import UIKit

public struct Text {

    public let value: String
    public let options: DisplayOptions?

    public init(value: String, options: DisplayOptions? = nil) {

        self.value = value
        self.options = options
    }
}

public struct Block {

    public let items: [Item]
    public let options: DisplayOptions?

    public init(items: [Item], options: DisplayOptions? = nil) {

        self.items = items
        self.options = options
    }
}

public enum Item {

    case block(Block)
    case text(Text)
}

public struct Component {

    public let items: [Item]

    public init(items: [Item]) {

        self.items = items
    }
}

public struct DisplayOptions {

    public let indentation: Indentation?
    public let fontWeight: FontWeight?

    public init(indentation: Indentation? = nil,
                fontWeight: FontWeight? = nil) {

        self.indentation = indentation
        self.fontWeight = fontWeight
    }
}

extension DisplayOptions {

    // Bullets
    public enum Indentation {
        case listItem(bulletStyle: BulletStyle)
    }

    public enum BulletStyle {

        case point

        public var stringRepresentation: String {

            switch self {
            case .point:
                return "•\t"
            }
        }
    }

    //Bold
    public enum FontWeight {

        case bold

        public var symbolicTraits: UIFontDescriptor.SymbolicTraits {
            switch self {
            case .bold:
                return .traitBold
            }
        }
    }
}

public typealias RichText = NSAttributedString

extension RichText {

    public convenience init(from component: Component, font: UIFont) {

        let initialString = NSMutableAttributedString(string: "", attributes: [.font: font])

        let attributedString = component.items.reduce(initialString) { partialResult, item -> NSMutableAttributedString in

            let itemAttributedString = Self.richText(from: item, font: font)

            partialResult.append(itemAttributedString)

            return partialResult
        }

        self.init(attributedString: attributedString)
    }

    private static func richText(from item: Item, font: UIFont) -> RichText {

        switch item {

        case .text(let text):
            return self.richText(from: text, font: font)

        case .block(let block):
            return self.richText(from: block, font: font)
        }
    }

    private static func richText(from block: Block, font: UIFont) -> RichText {

        let initialString = NSMutableAttributedString(string: "", attributes: [.font: font])

        let blockAttributedString = block.items.reduce(initialString) { partialResult, item -> NSMutableAttributedString in

            let itemAttributedString = self.richText(from: item, font: font)

            partialResult.append(itemAttributedString)

            return partialResult
        }

        return self.richText(from: blockAttributedString, options: block.options, font: font)
    }

    private static func richText(from text: Text, font: UIFont) -> RichText {

        let initialRichText = NSAttributedString(string: text.value, attributes: [.font: font])

        return self.richText(from: initialRichText, options: text.options, font: font)
    }

    private static func richText(from richText: RichText, options: DisplayOptions?, font: UIFont) -> RichText {

        let mutableAttributedString = NSMutableAttributedString(attributedString: richText)

        if case .listItem(let bulletStyle) = options?.indentation {

            let bulletAttributedString = NSAttributedString(string: bulletStyle.stringRepresentation, attributes: [.font: font])
            mutableAttributedString.insert(bulletAttributedString,
                                           at: 0)
            mutableAttributedString.insert(NSAttributedString(string: "\n"), at: mutableAttributedString.length)
        }

        if let symbolicTraits = options?.fontWeight?.symbolicTraits,
           let fontDescriptor = font.fontDescriptor.withSymbolicTraits(symbolicTraits) {

            let boldFont = UIFont(descriptor: fontDescriptor,
                                  size: 0)

            mutableAttributedString.addAttribute(.font,
                                                 value: boldFont,
                                                 range: NSRange(location: 0, length: mutableAttributedString.length))
        }

        return mutableAttributedString
    }
}
