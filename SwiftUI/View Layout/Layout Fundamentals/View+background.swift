@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Places a view behind the current view.
    ///
    /// The layout of the original view will be unchanged from this. Its original
    /// size and location will stay the same.
    ///
    /// If you would like to place a view in front of your current view instead,
    /// you can use the ``View/overlay(_:alignment:)`` function.
    ///
    /// ```
    /// struct OverlayView: View {
    ///     var body: some View {
    ///         Text("I have a floral background")
    ///             .background(Text("🌸🌹🌺💐"))
    ///     }
    /// }
    /// ```
    ///
    /// ![A TextView reading "I have a floral background" with the corresponding
    /// background text "🌸🌹🌺💐" aligned beneath it.](background.png)
    ///
    /// Check out ``View/overlay(_:alignment:)``, which is the opposite
    /// modifier.
    ///
    /// - Parameters:
    ///   - background: The view to place behind.
    ///   - alignment: Where to align the behind view relative to the current view. Defaults to center.
    @available(iOS, introduced: 13.0, deprecated: 100000.0, message: "Use `background(alignment:content:)` instead.")
    @available(macOS, introduced: 10.15, deprecated: 100000.0, message: "Use `background(alignment:content:)` instead.")
    @available(tvOS, introduced: 13.0, deprecated: 100000.0, message: "Use `background(alignment:content:)` instead.")
    @available(watchOS, introduced: 6.0, deprecated: 100000.0, message: "Use `background(alignment:content:)` instead.")
    @inlinable public func background<Background>(_ background: Background, alignment: Alignment = .center) -> some View where Background : View { }

}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension View {

    /// Layers the views that you specify behind this view.
    ///
    /// Use this modifier to place one or more views behind another view.
    /// For example, you can place a collection of stars beind a ``Text`` view:
    ///
    ///     Text("ABCDEF")
    ///         .background(alignment: .leading) { Star(color: .red) }
    ///         .background(alignment: .center) { Star(color: .green) }
    ///         .background(alignment: .trailing) { Star(color: .blue) }
    ///
    /// The example above assumes that you've defined a `Star` view with a
    /// parameterized color:
    ///
    ///     struct Star: View {
    ///         var color: Color
    ///
    ///         var body: some View {
    ///             Image(systemName: "star.fill")
    ///                 .foregroundStyle(color)
    ///         }
    ///     }
    ///
    /// By setting different `alignment` values for each modifier, you make the
    /// stars appear in different places behind the text:
    ///
    /// ![A screenshot of the letters A, B, C, D, E, and F written in front of
    /// three stars. The stars, from left to right, are red, green, and
    /// blue.](View-background-2)
    ///
    /// If you specify more than one view in the `content` closure, the modifier
    /// collects all of the views in the closure into an implicit ``ZStack``,
    /// taking them in order from back to front. For example, you can layer a
    /// vertical bar behind a circle, with both of those behind a horizontal
    /// bar:
    ///
    ///     Color.blue
    ///         .frame(width: 200, height: 10) // Creates a horizontal bar.
    ///         .background {
    ///             Color.green
    ///                 .frame(width: 10, height: 100) // Creates a vertical bar.
    ///             Circle()
    ///                 .frame(width: 50, height: 50)
    ///         }
    ///
    /// Both the background modifier and the implicit ``ZStack`` composed from
    /// the background content --- the circle and the vertical bar --- use a
    /// default ``Alignment/center`` alignment. The vertical bar appears
    /// centered behind the circle, and both appear as a composite view centered
    /// behind the horizontal bar:
    ///
    /// ![A screenshot of a circle with a horizontal blue bar layered on top
    /// and a vertical green bar layered underneath. All of the items are center
    /// aligned.](View-background-3)
    ///
    /// If you specify an alignment for the background, it applies to the
    /// implicit stack rather than to the individual views in the closure. You
    /// can see this if you add the ``Alignment/leading`` alignment:
    ///
    ///     Color.blue
    ///         .frame(width: 200, height: 10)
    ///         .background(alignment: .leading) {
    ///             Color.green
    ///                 .frame(width: 10, height: 100)
    ///             Circle()
    ///                 .frame(width: 50, height: 50)
    ///         }
    ///
    /// The vertical bar and the circle move as a unit to align the stack
    /// with the leading edge of the horizontal bar, while the
    /// vertical bar remains centered on the circle:
    ///
    /// ![A screenshot of a horizontal blue bar in front of a circle, which
    /// is in front of a vertical green bar. The horizontal bar and the circle
    /// are center aligned with each other; the left edges of the circle
    /// and the horizontal are aligned.](View-background-3a)
    ///
    /// To control the placement of individual items inside the `content`
    /// closure, either use a different background modifier for each item, as
    /// the earlier example of stars under text demonstrates, or add an explicit
    /// ``ZStack`` inside the content closure with its own alignment:
    ///
    ///     Color.blue
    ///         .frame(width: 200, height: 10)
    ///         .background(alignment: .leading) {
    ///             ZStack(alignment: .leading) {
    ///                 Color.green
    ///                     .frame(width: 10, height: 100)
    ///                 Circle()
    ///                     .frame(width: 50, height: 50)
    ///             }
    ///         }
    ///
    /// The stack alignment ensures that the circle's leading edge aligns with
    /// the vertical bar's, while the background modifier aligns the composite
    /// view with the horizontal bar:
    ///
    /// ![A screenshot of a horizontal blue bar in front of a circle, which
    /// is in front of a vertical green bar. All items are aligned on their
    /// left edges.](View-background-4)
    ///
    /// You can achieve layering without a background modifier by putting both
    /// the modified view and the background content into a ``ZStack``. This
    /// produces a simpler view hierarchy, but it changes the layout priority
    /// that SwiftUI applies to the views. Use the background modifier when you
    /// want the modified view to dominate the layout.
    ///
    /// If you want to specify a ``ShapeStyle`` like a
    /// ``HierarchicalShapeStyle`` or a ``Material`` as the background, use
    /// ``View/background(_:ignoresSafeAreaEdges:)`` instead.
    /// To specify a ``Shape`` or ``InsettableShape``, use
    /// ``View/background(_:in:fillStyle:)-89n7j`` or
    /// ``View/background(_:in:fillStyle:)-20tq5``, respectively.
    ///
    /// - Parameters:
    ///   - alignment: The alignment that the modifier uses to position the
    ///     implicit ``ZStack`` that groups the background views. The default
    ///     is ``Alignment/center``.
    ///   - content: A ``ViewBuilder`` that you use to declare the views to draw
    ///     behind this view, stacked in a cascading order from bottom to top.
    ///     The last view that you list appears at the front of the stack.
    ///
    /// - Returns: A view that uses the specified content as a background.
    @inlinable public func background<V>(alignment: Alignment = .center, @ViewBuilder content: () -> V) -> some View where V : View { }


    /// Sets the view's background to the default background style.
    ///
    /// This modifier behaves like ``View/background(_:ignoresSafeAreaEdges:)``,
    /// except that it always uses the ``ShapeStyle/background`` shape style.
    /// For example, you can add a background to a ``Label``:
    ///
    ///     ZStack {
    ///         Color.teal
    ///         Label("Flag", systemImage: "flag.fill")
    ///             .padding()
    ///             .background()
    ///     }
    ///
    /// Without the background modifier, the teal color behind the label shows
    /// through the label. With the modifier, the label's text and icon appear
    /// backed by a region filled with a color that's appropriate for light
    /// or dark appearance:
    ///
    /// ![A screenshot of a flag icon and the word flag inside a rectangle; the
    /// rectangle is filled with the background color and layered on top of a
    /// larger rectangle that's filled with the color teal.](View-background-7)
    ///
    /// If you want to specify a ``View`` or a stack of views as the background,
    /// use ``View/background(alignment:content:)`` instead.
    /// To specify a ``Shape`` or ``InsettableShape``, use
    /// ``View/background(_:in:fillStyle:)-89n7j`` or
    /// ``View/background(_:in:fillStyle:)-20tq5``, respectively.
    ///
    /// - Parameters:
    ///   - edges: The set of edges for which to ignore safe area insets
    ///     when adding the background. The default value is ``Edge/Set/all``.
    ///     Specify an empty set to respect safe area insets on all edges.
    ///
    /// - Returns: A view with the ``ShapeStyle/background`` shape style
    ///   drawn behind it.
    @inlinable public func background(ignoresSafeAreaEdges edges: Edge.Set = .all) -> some View { }


    /// Sets the view's background to a style.
    ///
    /// Use this modifier to place a type that conforms to the ``ShapeStyle``
    /// protocol --- like a ``Color``, ``Material``, or
    /// ``HierarchicalShapeStyle`` --- behind a view. For example, you can add
    /// the ``ShapeStyle/regularMaterial`` behind a ``Label``:
    ///
    ///     struct FlagLabel: View {
    ///         var body: some View {
    ///             Label("Flag", systemImage: "flag.fill")
    ///                 .padding()
    ///                 .background(.regularMaterial)
    ///         }
    ///     }
    ///
    /// SwiftUI anchors the style to the view's bounds. For the example above,
    /// the background fills the entirety of the label's frame, which includes
    /// the padding:
    ///
    /// ![A screenshot of a flag symbol and the word flag layered over a
    /// gray rectangle.](View-background-5)
    ///
    /// SwiftUI limits the background style's extent to the modified view's
    /// container-relative shape. You can see this effect if you constrain the
    /// `FlagLabel` view with a ``View/containerShape(_:)`` modifier:
    ///
    ///     FlagLabel()
    ///         .containerShape(RoundedRectangle(cornerRadius: 16))
    ///
    /// The background takes on the specified container shape:
    ///
    /// ![A screenshot of a flag symbol and the word flag layered over a
    /// gray rectangle with rounded corners.](View-background-6)
    ///
    /// By default, the background ignores safe area insets on all edges, but
    /// you can provide a specific set of edges to ignore, or an empty set to
    /// respect safe area insets on all edges:
    ///
    ///     Rectangle()
    ///         .background(
    ///             .regularMaterial,
    ///             ignoresSafeAreaEdges: []) // Ignore no safe area insets.
    ///
    /// If you want to specify a ``View`` or a stack of views as the background,
    /// use ``View/background(alignment:content:)`` instead.
    /// To specify a ``Shape`` or ``InsettableShape``, use
    /// ``View/background(_:in:fillStyle:)-89n7j`` or
    /// ``View/background(_:in:fillStyle:)-20tq5``, respectively.
    ///
    /// - Parameters:
    ///   - style: An instance of a type that conforms to ``ShapeStyle`` that
    ///     SwiftUI draws behind the modified view.
    ///   - edges: The set of edges for which to ignore safe area insets
    ///     when adding the background. The default value is ``Edge/Set/all``.
    ///     Specify an empty set to respect safe area insets on all edges.
    ///
    /// - Returns: A view with the specified style drawn behind it.
    @inlinable public func background<S>(_ style: S, ignoresSafeAreaEdges edges: Edge.Set = .all) -> some View where S : ShapeStyle { }


    /// Sets the view's background to a shape filled with the
    /// default background style.
    ///
    /// This modifier behaves like ``View/background(_:in:fillStyle:)-89n7j``,
    /// except that it always uses the ``ShapeStyle/background`` shape style
    /// to fill the specified shape. For example, you can create a ``Path``
    /// that outlines a trapezoid:
    ///
    ///     let trapezoid = Path { path in
    ///         path.move(to: .zero)
    ///         path.addLine(to: CGPoint(x: 90, y: 0))
    ///         path.addLine(to: CGPoint(x: 80, y: 50))
    ///         path.addLine(to: CGPoint(x: 10, y: 50))
    ///     }
    ///
    /// Then you can use that shape as a background for a ``Label``:
    ///
    ///     ZStack {
    ///         Color.teal
    ///         Label("Flag", systemImage: "flag.fill")
    ///             .padding()
    ///             .background(in: trapezoid)
    ///     }
    ///
    /// Without the background modifier, the fill color shows
    /// through the label. With the modifier, the label's text and icon appear
    /// backed by a shape filled with a color that's appropriate for light
    /// or dark appearance:
    ///
    /// ![A screenshot of a flag icon and the word flag inside a trapezoid; the
    /// trapezoid is filled with the background color and layered on top of
    /// a rectangle filled with the color teal.](View-background-B)
    ///
    /// To create a background with other ``View`` types --- or with a stack
    /// of views --- use ``View/background(alignment:content:)`` instead.
    /// To add a ``ShapeStyle`` as a background, use
    /// ``View/background(_:ignoresSafeAreaEdges:)``.
    ///
    /// - Parameters:
    ///   - shape: An instance of a type that conforms to ``Shape`` that
    ///     SwiftUI draws behind the view using the ``ShapeStyle/background``
    ///     shape style.
    ///   - fillStyle: The ``FillStyle`` to use when drawing the shape.
    ///     The default style uses the nonzero winding number rule and
    ///     antialiasing.
    ///
    /// - Returns: A view with the specified shape drawn behind it.
    @inlinable public func background<S>(in shape: S, fillStyle: FillStyle = FillStyle()) -> some View where S : Shape { }


    /// Sets the view's background to a shape filled with a style.
    ///
    /// Use this modifier to layer a type that conforms to the ``Shape``
    /// protocol behind a view. Specify the ``ShapeStyle`` that's used to
    /// fill the shape. For example, you can create a ``Path`` that outlines
    /// a trapezoid:
    ///
    ///     let trapezoid = Path { path in
    ///         path.move(to: .zero)
    ///         path.addLine(to: CGPoint(x: 90, y: 0))
    ///         path.addLine(to: CGPoint(x: 80, y: 50))
    ///         path.addLine(to: CGPoint(x: 10, y: 50))
    ///     }
    ///
    /// Then you can use that shape as a background for a ``Label``:
    ///
    ///     Label("Flag", systemImage: "flag.fill")
    ///         .padding()
    ///         .background(.teal, in: trapezoid)
    ///
    /// The ``ShapeStyle/teal`` color fills the shape:
    ///
    /// ![A screenshot of the flag icon and the word flag inside a trapezoid;
    /// The trapezoid is filled with the color teal.](View-background-A)
    ///
    /// This modifier and ``View/background(_:in:fillStyle:)-20tq5`` are
    /// convenience methods for placing a single shape behind a view. To
    /// create a background with other ``View`` types --- or with a stack
    /// of views --- use ``View/background(alignment:content:)`` instead.
    /// To add a ``ShapeStyle`` as a background, use
    /// ``View/background(_:ignoresSafeAreaEdges:)``.
    ///
    /// - Parameters:
    ///   - style: A ``ShapeStyle`` that SwiftUI uses to the fill the shape
    ///     that you specify.
    ///   - shape: An instance of a type that conforms to ``Shape`` that
    ///     SwiftUI draws behind the view.
    ///   - fillStyle: The ``FillStyle`` to use when drawing the shape.
    ///     The default style uses the nonzero winding number rule and
    ///     antialiasing.
    ///
    /// - Returns: A view with the specified shape drawn behind it.
    @inlinable public func background<S, T>(_ style: S, in shape: T, fillStyle: FillStyle = FillStyle()) -> some View where S : ShapeStyle, T : Shape { }


    /// Sets the view's background to an insettable shape filled with the
    /// default background style.
    ///
    /// This modifier behaves like ``View/background(_:in:fillStyle:)-20tq5``,
    /// except that it always uses the ``ShapeStyle/background`` shape style
    /// to fill the specified insettable shape. For example, you can use
    /// a ``RoundedRectangle`` as a background on a ``Label``:
    ///
    ///     ZStack {
    ///         Color.teal
    ///         Label("Flag", systemImage: "flag.fill")
    ///             .padding()
    ///             .background(in: RoundedRectangle(cornerRadius: 8))
    ///     }
    ///
    /// Without the background modifier, the fill color shows
    /// through the label. With the modifier, the label's text and icon appear
    /// backed by a shape filled with a color that's appropriate for light
    /// or dark appearance:
    ///
    /// ![A screenshot of a flag icon and the word flag inside a rectangle with
    /// rounded corners; the rectangle is filled with the background color, and
    /// is layered on top of a larger rectangle that's filled with the color
    /// teal.](View-background-9)
    ///
    /// To create a background with other ``View`` types --- or with a stack
    /// of views --- use ``View/background(alignment:content:)`` instead.
    /// To add a ``ShapeStyle`` as a background, use
    /// ``View/background(_:ignoresSafeAreaEdges:)``.
    ///
    /// - Parameters:
    ///   - shape: An instance of a type that conforms to ``InsettableShape``
    ///     that SwiftUI draws behind the view using the
    ///     ``ShapeStyle/background`` shape style.
    ///   - fillStyle: The ``FillStyle`` to use when drawing the shape.
    ///     The default style uses the nonzero winding number rule and
    ///     antialiasing.
    ///
    /// - Returns: A view with the specified insettable shape drawn behind it.
    @inlinable public func background<S>(in shape: S, fillStyle: FillStyle = FillStyle()) -> some View where S : InsettableShape { }


    /// Sets the view's background to an insettable shape filled with a style.
    ///
    /// Use this modifier to layer a type that conforms to the
    /// ``InsettableShape`` protocol --- like a ``Rectangle``, ``Circle``, or
    /// ``Capsule`` --- behind a view. Specify the ``ShapeStyle`` that's used to
    /// fill the shape. For example, you can place a ``RoundedRectangle``
    /// behind a ``Label``:
    ///
    ///     Label("Flag", systemImage: "flag.fill")
    ///         .padding()
    ///         .background(.teal, in: RoundedRectangle(cornerRadius: 8))
    ///
    /// The ``ShapeStyle/teal`` color fills the shape:
    ///
    /// ![A screenshot of the flag icon and word on a teal rectangle with
    /// rounded corners.](View-background-8)
    ///
    /// This modifier and ``View/background(_:in:fillStyle:)-89n7j`` are
    /// convenience methods for placing a single shape behind a view. To
    /// create a background with other ``View`` types --- or with a stack
    /// of views --- use ``View/background(alignment:content:)`` instead.
    /// To add a ``ShapeStyle`` as a background, use
    /// ``View/background(_:ignoresSafeAreaEdges:)``.
    ///
    /// - Parameters:
    ///   - style: A ``ShapeStyle`` that SwiftUI uses to the fill the shape
    ///     that you specify.
    ///   - shape: An instance of a type that conforms to ``InsettableShape``
    ///     that SwiftUI draws behind the view.
    ///   - fillStyle: The ``FillStyle`` to use when drawing the shape.
    ///     The default style uses the nonzero winding number rule and
    ///     antialiasing.
    ///
    /// - Returns: A view with the specified insettable shape drawn behind it.
    @inlinable public func background<S, T>(_ style: S, in shape: T, fillStyle: FillStyle = FillStyle()) -> some View where S : ShapeStyle, T : InsettableShape { }

}
