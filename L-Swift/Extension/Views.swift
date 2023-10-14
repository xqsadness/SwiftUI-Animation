
import Foundation
import SwiftUI


// MARK: - Custom view extension for ui building
extension View{
    func closeKeyBoard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func disableWithOpacity(_ condition: Bool) -> some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    func hAlign(_ alignment: Alignment) -> some View{
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) -> some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }

    //    Mark: custom border view with padding
    func border (_ width: CGFloat, _ color: Color) -> some View{
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background{
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(color,lineWidth: width)
            }
    }
    
    //    Mark: custom fill view with padding
    func fillView (_ color: Color) -> some View{
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background{
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(color)
            }
    }
    
    func linearGradient()->some View{
        LinearGradient(gradient: Gradient(colors: [Color(hex: "2C2A4B"), Color(hex: "1E1E2F")]), startPoint: .top, endPoint: .bottom)
            .frame(height: 90)
    }
    
    func angularGradient()->some View{
        AngularGradient(gradient: Gradient(colors: [.red, .purple, .blue, .green, .yellow, .red]), center: .center)
    }
    
    func styledText(text: String, foregroundColor: Color, font: Font) -> some View {
        Text(text)
            .foregroundColor(foregroundColor)
            .font(font)
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

extension View {
#if os(iOS)
    func onBackground(_ f: @escaping () -> Void) -> some View {
        self.onReceive(
            NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification),
            perform: { _ in f() }
        )
    }
    
    func onForeground(_ f: @escaping () -> Void) -> some View {
        self.onReceive(
            NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification),
            perform: { _ in f() }
        )
    }
#else
    func onBackground(_ f: @escaping () -> Void) -> some View {
        self.onReceive(
            NotificationCenter.default.publisher(for: NSApplication.willResignActiveNotification),
            perform: { _ in f() }
        )
    }
    
    func onForeground(_ f: @escaping () -> Void) -> some View {
        self.onReceive(
            NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification),
            perform: { _ in f() }
        )
    }
#endif
}

extension View {
    func popup<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        return ZStack {
            self
            
            if isPresented.wrappedValue {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .onTapGesture {
                        isPresented.wrappedValue = false
                    }
                
                content()
                    .transition(.scale)
            }
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
