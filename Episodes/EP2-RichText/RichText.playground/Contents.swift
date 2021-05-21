//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {

        let font = UIFont.systemFont(ofSize: 24)

        let availableColorsItem: Item = .text(Text(value: "Available colors:\n"))
        let darkBlueItem: Item = .block(Block(items: [
            .text(Text(value: "Dark ", options: DisplayOptions(fontWeight: .bold))),
            .text(Text(value: "blue"))
        ],
                                              options: DisplayOptions(indentation: .listItem(bulletStyle: .point))))
        let pinkItem: Item = .text(Text(value: "Pink", options: DisplayOptions(indentation: .listItem(bulletStyle: .point))))

        let richTextComponent = Component(items: [availableColorsItem, darkBlueItem, pinkItem])

        let richText = RichText(from: richTextComponent, font: font)

        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 200)
        label.numberOfLines = 0
        label.attributedText = richText
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
