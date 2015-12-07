//: Playground - noun: a place where people can play

import Cocoa

@IBDesignable class BulbImageView: NSImageView {
    
    var active = false {
        didSet {
            setupLight()
        }
    }
    @IBInspectable var color = NSColor.redColor() {
        didSet {
            setupLight()
        }
    }
    
    let strand = NSImage(named: "customColorBase")
    let bulbOff = NSImage(named: "customColorOff")
    let bulbOn = NSImage(named: "customColorOn")
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    init(height: CGFloat) {
        super.init(frame: NSRect(origin: CGPointZero, size: CGSize(width: height * 300 / 483, height: height)))
        self.setupLight()
    }
    
    func setupLight() {
        self.imageScaling = .ScaleProportionallyUpOrDown

        let bulb = bulbOff!
        let bright = bulbOn!

        bulb.lockFocus()
        let drawColor = NSColor(calibratedRed: color.redComponent * 0.8, green: color.greenComponent * 0.8, blue: color.blueComponent * 0.8, alpha: color.alphaComponent * 0.5)
        drawColor.set()
        NSRectFillUsingOperation(NSRect(origin: NSZeroPoint, size: bulb.size), .CompositeSourceAtop)
        
        strand?.drawInRect(NSRect(origin: NSZeroPoint, size: bulb.size))
        bulb.unlockFocus()
        
        if active {
            bright.lockFocus()
            color.colorWithAlphaComponent(0.8).set()
            NSRectFillUsingOperation(NSRect(origin: NSZeroPoint, size: bulb.size), .CompositeSourceAtop)
            bright.unlockFocus()
            
            bulb.lockFocus()
            bright.drawInRect(NSRect(origin: NSZeroPoint, size: bulb.size))
            bulb.unlockFocus()
        }
        
        self.image = bulb
        
    }
    
}

let bulbImageView = BulbImageView(height: 400)
bulbImageView.active = true
bulbImageView.active = false
