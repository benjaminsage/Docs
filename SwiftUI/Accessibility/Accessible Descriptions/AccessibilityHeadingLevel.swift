/// The hierarchy of a heading in relation other headings.
///
/// Assistive technologies can use this to improve a users navigation
/// through multiple headings. When users navigate through top level
/// headings they expect the content for each heading to be unrelated.
///
/// For example, you can categorize a list of available products into sections,
/// like Fruits and Vegetables. With only top level headings, this list requires no
/// heading hierarchy, and you use the ``unspecified`` heading level. On the other hand, if sections
/// contain subsections, like if the Fruits section has subsections for varieties of Apples,
/// Pears, and so on, you apply the ``h1`` level to Fruits and Vegetables, and the ``h2``
/// level to Apples and Pears.
///
/// Except for ``h1``, be sure to precede all leveled headings by another heading with a level
/// that's one less.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@frozen public enum AccessibilityHeadingLevel : UInt {

    /// A heading without a hierarchy.
    case unspecified

    /// Level 1 heading.
    case h1

    /// Level 2 heading.
    case h2

    /// Level 3 heading.
    case h3

    /// Level 4 heading.
    case h4

    /// Level 5 heading.
    case h5

    /// Level 6 heading.
    case h6

}
