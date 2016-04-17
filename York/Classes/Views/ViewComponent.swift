import UIKit

@IBDesignable
public class ViewComponent: UIView {

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.load()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.load()        
    }
    
    public func load() {
        let className = self.dynamicType.simpleClassName()
        let view = NSBundle(forClass: self.dynamicType).loadNibNamed(className, owner: self, options: nil).first as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
        
}
