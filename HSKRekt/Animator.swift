import UIKit
class FadeInAnimator: NSObject,
UIViewControllerAnimatedTransitioning {

    
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
        ) -> TimeInterval {
        return 0.35
    }
   
    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning) {
    //    let containerView = transitionContext.containerView
        let src = transitionContext.viewController(
            forKey: UITransitionContextViewControllerKey.from)!
        let dst = transitionContext.viewController(
            forKey: UITransitionContextViewControllerKey.to)!
       
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        transitionContext.completeTransition(true)
        }
        )
        
      
    }
  
}

class NavigationControllerDelegate: NSObject,
UINavigationControllerDelegate {
    
    internal func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation:
        UINavigationControllerOperation,
        from fromVC: UIViewController,
        to toVC: UIViewController
        ) -> UIViewControllerAnimatedTransitioning? {
        
        if fromVC is DetailViewController && toVC is EnterWordViewController{
            return FadeInAnimator()}
        else {return nil}
    }
}
