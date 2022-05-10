extension UIView {
    /// 圆角优化 离屏渲染优化方案
    func cornerRadius(radius: CGFloat,
                      corners: UIRectCorner,
                      color: UIColor? = nil,
                      lineWidth: CGFloat = 0) {
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let radiusLayer = CAShapeLayer()
        radiusLayer.frame = self.bounds
        radiusLayer.path = bezierPath.cgPath
        self.layer.mask = radiusLayer
        
        if  let borderColor = color {
            // 添加border
            let borderLayer = CAShapeLayer()
            borderLayer.frame = self.bounds
            borderLayer.path = bezierPath.cgPath
            borderLayer.lineWidth = lineWidth
            borderLayer.strokeColor = borderColor.cgColor
            borderLayer.fillColor = UIColor.clear.cgColor
            if let layers: NSArray = self.layer.sublayers as NSArray? {
                if let last = layers.lastObject as AnyObject? {
                    if last.isKind(of: CAShapeLayer.self) {
                        last.removeFromSuperlayer()
                    }
                }
            }
            self.layer.addSublayer(borderLayer)
        }
    }
}

