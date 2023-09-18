// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import Foundation
#if SKIP
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.material3.__
import androidx.compose.material.icons.__
import androidx.compose.material.icons.filled.__
#else
import struct CoreGraphics.CGFloat
import struct CoreGraphics.CGRect
import struct CoreGraphics.CGSize
#endif

public struct Image : View, Equatable, Sendable {
    let image: ImageType

    enum ImageType : Equatable, Sendable {
        case named(name: String, bundle: Bundle?, label: Text?)
        case decorative(name: String, bundle: Bundle?)
        case system(systemName: String)
    }

    @available(*, unavailable)
    public init(_ name: String, bundle: Bundle? = nil) {
        self.image = .named(name: name, bundle: bundle, label: nil)
    }

    @available(*, unavailable)
    public init(_ name: String, bundle: Bundle? = nil, label: Text) {
        self.image = .named(name: name, bundle: bundle, label: label)
    }

    @available(*, unavailable)
    public init(decorative name: String, bundle: Bundle? = nil) {
        self.image = .decorative(name: name, bundle: bundle)
    }

    public init(systemName: String) {
        self.image = .system(systemName: systemName)
    }

    // TODO: implement compose view
    #if SKIP
    @Composable public override func ComposeContent(context: ComposeContext) {
        // The best way would be to switch here, but the generated closures are not @Composable, leading to:
        // error: @Composable invocations can only happen from the context of a @Composable function

        //switch image {
        //case .system(let systemName):
        //    androidx.compose.material3.Icon(modifier: context.modifier, imageVector: systemImage(named: systemName), contentDescription: systemName)
        //case .decorative(let name, let bundle): break // TODO: non-system images
        //case .named(let name, let bunle, let label): break // TODO: non-system images
        //}

        if case .system(let systemName) = self.image {
            if let image = systemImage(named: systemName) {
                if let tintColor = EnvironmentValues.shared._color?.colorImpl() {
                    androidx.compose.material3.Icon(modifier: context.modifier, imageVector: image, tint: tintColor, contentDescription: systemName)
                } else {
                    androidx.compose.material3.Icon(imageVector: image, contentDescription: systemName)
                }
            } else {
                // TODO: throw error? Log message?
                print("Unable to find system image named: \(systemName)")
                androidx.compose.material3.Icon(imageVector: Icons.Default.Warning, contentDescription: "missing icon")
            }
        } else {
            androidx.compose.material3.Icon(imageVector: Icons.Default.Warning, contentDescription: "unsupported image type")
        }
    }

    private func systemImage(named name: String) -> ImageVector? {
        switch name {
        case "square.and.pencil": return Icons.Default.Edit
        case "square.and.pencil.fill": return Icons.Filled.Edit

        case "person.2": return Icons.Default.Person
        case "person.2.fill": return Icons.Filled.Person

        case "message": return Icons.Default.Message
        case "message.fill": return Icons.Filled.Message

        case "paperplane": return Icons.Default.Send
        case "paperplane.fill": return Icons.Filled.Send

        case "bell.slash": return Icons.Default.NotificationsOff
        case "bell.slash.fill": return Icons.Filled.NotificationsOff

        case "house": return Icons.Default.Home
        case "house.fill": return Icons.Filled.Home

        case "gear": return Icons.Default.Settings
        case "gear.fill": return Icons.Filled.Settings

        case "gearshape": return Icons.Default.Settings
        case "gearshape.fill": return Icons.Filled.Settings

        case "star": return Icons.Default.Star
        case "star.fill": return Icons.Filled.Star

        case "person.crop.circle": return Icons.Default.AccountCircle
        case "person.crop.circle.fill": return Icons.Filled.AccountCircle

        case "calendar": return Icons.Default.CalendarToday
        case "calendar.fill": return Icons.Filled.CalendarToday

        case "camera": return Icons.Default.Camera
        case "camera.fill": return Icons.Filled.Camera

        case "cloud": return Icons.Default.Cloud
        case "cloud.fill": return Icons.Filled.Cloud

        case "music.note": return Icons.Default.MusicNote
        case "music.note.fill": return Icons.Filled.MusicNote

        case "globe.americas": return Icons.Default.Public
        case "globe.americas.fill": return Icons.Filled.Public

        case "sun.max": return Icons.Default.WbSunny
        case "sun.max.fill": return Icons.Filled.WbSunny

        case "moon": return Icons.Default.Nightlight
        case "moon.fill": return Icons.Filled.Nightlight

        case "book": return Icons.Default.Book
        case "book.fill": return Icons.Filled.Book

        case "gamecontroller": return Icons.Default.VideogameAsset
        case "gamecontroller.fill": return Icons.Filled.VideogameAsset

        case "flag": return Icons.Default.Flag
        case "flag.fill": return Icons.Filled.Flag

        case "heart": return Icons.Default.Favorite
        case "heart.fill": return Icons.Filled.Favorite

        case "bolt": return Icons.Default.FlashOn
        case "bolt.fill": return Icons.Filled.FlashOn

        case "camera.metering.center.weighted": return Icons.Default.CenterFocusStrong
        case "camera.metering.center.weighted.fill": return Icons.Filled.CenterFocusStrong

        case "bandage": return Icons.Default.Healing
        case "bandage.fill": return Icons.Filled.Healing

        case "headphones.circle": return Icons.Default.Headset
        case "headphones.circle.fill": return Icons.Filled.Headset

        case "hourglass": return Icons.Default.HourglassFull
        case "hourglass.fill": return Icons.Filled.HourglassFull

        case "mic": return Icons.Default.Mic
        case "mic.fill": return Icons.Filled.Mic

        case "eye.slash": return Icons.Default.VisibilityOff
        case "eye.slash.fill": return Icons.Filled.VisibilityOff

        case "heart.slash": return Icons.Default.FavoriteBorder
        case "heart.slash.fill": return Icons.Filled.FavoriteBorder

        case "video": return Icons.Default.VideoCall
        case "video.fill": return Icons.Filled.VideoCall

        case "printer": return Icons.Default.Print
        case "printer.fill": return Icons.Filled.Print

        case "cart": return Icons.Default.ShoppingCart
        case "cart.fill": return Icons.Filled.ShoppingCart

        case "wifi.slash": return Icons.Default.WifiOff
        case "wifi.slash.fill": return Icons.Filled.WifiOff

        case "person.badge.plus": return Icons.Default.PersonAdd
        case "person.badge.plus.fill": return Icons.Filled.PersonAdd

        case "folder": return Icons.Default.Folder
        case "folder.fill": return Icons.Filled.Folder

        case "pianokeys": return Icons.Default.MusicNote
        case "pianokeys.fill": return Icons.Filled.MusicNote

        case "gamecontroller": return Icons.Default.VideogameAsset
        case "gamecontroller.fill": return Icons.Filled.VideogameAsset

        case "sunrise": return Icons.Default.WbSunny
        case "sunrise.fill": return Icons.Filled.WbSunny

        case "lock": return Icons.Default.Lock
        case "lock.fill": return Icons.Filled.Lock

        case "paperclip.circle": return Icons.Default.AttachFile
        case "paperclip.circle.fill": return Icons.Filled.AttachFile

        case "alarm": return Icons.Default.Alarm
        case "alarm.fill": return Icons.Filled.Alarm

        case "arrow.down.circle": return Icons.Default.ArrowDownward
        case "arrow.down.circle.fill": return Icons.Filled.ArrowDownward

        case "book": return Icons.Default.Book
        case "book.fill": return Icons.Filled.Book

        case "calendar.circle": return Icons.Default.Event
        case "calendar.circle.fill": return Icons.Filled.Event

        case "car": return Icons.Default.DirectionsCar
        case "car.fill": return Icons.Filled.DirectionsCar

        case "cloud": return Icons.Default.Cloud
        case "cloud.fill": return Icons.Filled.Cloud

        case "creditcard": return Icons.Default.CreditCard
        case "creditcard.fill": return Icons.Filled.CreditCard

        case "document": return Icons.Default.Description
        case "document.fill": return Icons.Filled.Description

        case "envelope": return Icons.Default.Email
        case "envelope.fill": return Icons.Filled.Email

        case "film": return Icons.Default.Movie
        case "film.fill": return Icons.Filled.Movie

        case "gift": return Icons.Default.CardGiftcard
        case "gift.fill": return Icons.Filled.CardGiftcard

        case "home": return Icons.Default.Home
        case "home.fill": return Icons.Filled.Home

        case "lightbulb": return Icons.Default.WbIncandescent
        case "lightbulb.fill": return Icons.Filled.WbIncandescent

        case "magnifyingglass": return Icons.Default.Search
        case "magnifyingglass.fill": return Icons.Filled.Search

        case "music.note": return Icons.Default.MusicNote
        case "music.note.fill": return Icons.Filled.MusicNote

        case "pencil": return Icons.Default.Edit
        case "pencil.fill": return Icons.Filled.Edit

        case "phone": return Icons.Default.Phone
        case "phone.fill": return Icons.Filled.Phone

        case "trash": return Icons.Default.Delete
        case "trash.fill": return Icons.Filled.Delete

        case "wrench": return Icons.Default.Settings
        case "wrench.fill": return Icons.Filled.Settings

        case "info": return Icons.Default.Info
        case "info.fill": return Icons.Filled.Info

        // fallbacks for actual android symbol names

        case "Icons.Default.AccountBox": return Icons.Default.AccountBox
        case "Icons.Default.AccountCircle": return Icons.Default.AccountCircle
        case "Icons.Default.AddCircle": return Icons.Default.AddCircle
        case "Icons.Default.Add": return Icons.Default.Add
        case "Icons.Default.ArrowDropDown": return Icons.Default.ArrowDropDown
        case "Icons.Default.Build": return Icons.Default.Build
        case "Icons.Default.Call": return Icons.Default.Call
        case "Icons.Default.CheckCircle": return Icons.Default.CheckCircle
        case "Icons.Default.Check": return Icons.Default.Check
        case "Icons.Default.Clear": return Icons.Default.Clear
        case "Icons.Default.Close": return Icons.Default.Close
        case "Icons.Default.Create": return Icons.Default.Create
        case "Icons.Default.DateRange": return Icons.Default.DateRange
        case "Icons.Default.Delete": return Icons.Default.Delete
        case "Icons.Default.Done": return Icons.Default.Done
        case "Icons.Default.Edit": return Icons.Default.Edit
        case "Icons.Default.Email": return Icons.Default.Email
        case "Icons.Default.Face": return Icons.Default.Face
        case "Icons.Default.FavoriteBorder": return Icons.Default.FavoriteBorder
        case "Icons.Default.Favorite": return Icons.Default.Favorite
        case "Icons.Default.Home": return Icons.Default.Home
        case "Icons.Default.Info": return Icons.Default.Info
        case "Icons.Default.KeyboardArrowDown": return Icons.Default.KeyboardArrowDown
        case "Icons.Default.KeyboardArrowUp": return Icons.Default.KeyboardArrowUp
        case "Icons.Default.LocationOn": return Icons.Default.LocationOn
        case "Icons.Default.Lock": return Icons.Default.Lock
        case "Icons.Default.MailOutline": return Icons.Default.MailOutline
        case "Icons.Default.Menu": return Icons.Default.Menu
        case "Icons.Default.MoreVert": return Icons.Default.MoreVert
        case "Icons.Default.Notifications": return Icons.Default.Notifications
        case "Icons.Default.Person": return Icons.Default.Person
        case "Icons.Default.Phone": return Icons.Default.Phone
        case "Icons.Default.Place": return Icons.Default.Place
        case "Icons.Default.PlayArrow": return Icons.Default.PlayArrow
        case "Icons.Default.Refresh": return Icons.Default.Refresh
        case "Icons.Default.Search": return Icons.Default.Search
        case "Icons.Default.Settings": return Icons.Default.Settings
        case "Icons.Default.Share": return Icons.Default.Share
        case "Icons.Default.ShoppingCart": return Icons.Default.ShoppingCart
        case "Icons.Default.Star": return Icons.Default.Star
        case "Icons.Default.ThumbUp": return Icons.Default.ThumbUp
        case "Icons.Default.Warning": return Icons.Default.Warning

        case "Icons.Filled.AccountBox": return Icons.Filled.AccountBox
        case "Icons.Filled.AccountCircle": return Icons.Filled.AccountCircle
        case "Icons.Filled.AddCircle": return Icons.Filled.AddCircle
        case "Icons.Filled.Add": return Icons.Filled.Add
        case "Icons.Filled.ArrowDropDown": return Icons.Filled.ArrowDropDown
        case "Icons.Filled.Build": return Icons.Filled.Build
        case "Icons.Filled.Call": return Icons.Filled.Call
        case "Icons.Filled.CheckCircle": return Icons.Filled.CheckCircle
        case "Icons.Filled.Check": return Icons.Filled.Check
        case "Icons.Filled.Clear": return Icons.Filled.Clear
        case "Icons.Filled.Close": return Icons.Filled.Close
        case "Icons.Filled.Create": return Icons.Filled.Create
        case "Icons.Filled.DateRange": return Icons.Filled.DateRange
        case "Icons.Filled.Delete": return Icons.Filled.Delete
        case "Icons.Filled.Done": return Icons.Filled.Done
        case "Icons.Filled.Edit": return Icons.Filled.Edit
        case "Icons.Filled.Email": return Icons.Filled.Email
        case "Icons.Filled.Face": return Icons.Filled.Face
        case "Icons.Filled.FavoriteBorder": return Icons.Filled.FavoriteBorder
        case "Icons.Filled.Favorite": return Icons.Filled.Favorite
        case "Icons.Filled.Home": return Icons.Filled.Home
        case "Icons.Filled.Info": return Icons.Filled.Info
        case "Icons.Filled.KeyboardArrowDown": return Icons.Filled.KeyboardArrowDown
        case "Icons.Filled.KeyboardArrowUp": return Icons.Filled.KeyboardArrowUp
        case "Icons.Filled.LocationOn": return Icons.Filled.LocationOn
        case "Icons.Filled.Lock": return Icons.Filled.Lock
        case "Icons.Filled.MailOutline": return Icons.Filled.MailOutline
        case "Icons.Filled.Menu": return Icons.Filled.Menu
        case "Icons.Filled.MoreVert": return Icons.Filled.MoreVert
        case "Icons.Filled.Notifications": return Icons.Filled.Notifications
        case "Icons.Filled.Person": return Icons.Filled.Person
        case "Icons.Filled.Phone": return Icons.Filled.Phone
        case "Icons.Filled.Place": return Icons.Filled.Place
        case "Icons.Filled.PlayArrow": return Icons.Filled.PlayArrow
        case "Icons.Filled.Refresh": return Icons.Filled.Refresh
        case "Icons.Filled.Search": return Icons.Filled.Search
        case "Icons.Filled.Settings": return Icons.Filled.Settings
        case "Icons.Filled.Share": return Icons.Filled.Share
        case "Icons.Filled.ShoppingCart": return Icons.Filled.ShoppingCart
        case "Icons.Filled.Star": return Icons.Filled.Star
        case "Icons.Filled.ThumbUp": return Icons.Filled.ThumbUp
        case "Icons.Filled.Warning": return Icons.Filled.Warning

        default: return Icons.Default.Warning
        }
    }
    #else
    public var body: some View {
        stubView()
    }
    #endif
}

#if !SKIP

// TODO: Process for use in SkipUI

import class CoreGraphics.CGContext
import struct CoreGraphics.CGFloat
import class CoreGraphics.CGImage
import struct CoreGraphics.CGRect
import struct CoreGraphics.CGSize
import class Foundation.Bundle


//#if canImport(CoreTransferable)
//import protocol CoreTransferable.Transferable
//
//@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
//extension Image : Transferable {
//
//    /// The representation used to import and export the item.
//    ///
//    /// A ``transferRepresentation`` can contain multiple representations
//    /// for different content types.
//    public static var transferRepresentation: Representation { get { return never() } }
//
//    /// The type of the representation used to import and export the item.
//    ///
//    /// Swift infers this type from the return value of the
//    /// ``transferRepresentation`` property.
//    public typealias Representation = Never
//}
//#endif

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension Image {

    /// Creates a system symbol image with a variable value.
    ///
    /// This initializer creates an image using a system-provided symbol. The
    /// rendered symbol may alter its appearance to represent the value
    /// provided in `variableValue`. Use symbols
    /// to find system symbols that support variable
    /// values and their corresponding names.
    ///
    /// The following example shows the effect of creating the `"chart.bar.fill"`
    /// symbol with different values.
    ///
    ///     HStack{
    ///         Image(systemName: "chart.bar.fill", variableValue: 0.3)
    ///         Image(systemName: "chart.bar.fill", variableValue: 0.6)
    ///         Image(systemName: "chart.bar.fill", variableValue: 1.0)
    ///     }
    ///     .font(.system(.largeTitle))
    ///
    /// ![Three instances of the bar chart symbol, arranged horizontally.
    /// The first fills one bar, the second fills two bars, and the last
    /// symbol fills all three bars.](Image-3)
    ///
    /// To create a custom symbol image from your app's asset
    /// catalog, use ``Image/init(_:variableValue:bundle:)`` instead.
    ///
    /// - Parameters:
    ///   - systemName: The name of the system symbol image.
    ///     Use the SF Symbols app to look up the names of system
    ///     symbol images.
    ///   - variableValue: An optional value between `0.0` and `1.0` that
    ///     the rendered image can use to customize its appearance, if
    ///     specified. If the symbol doesn't support variable values, this
    ///     parameter has no effect. Use the SF Symbols app to look up which
    ///     symbols support variable values.
    public init(systemName: String, variableValue: Double?) { fatalError() }

    /// Creates a labeled image that you can use as content for controls,
    /// with a variable value.
    ///
    /// This initializer creates an image using a using a symbol in the
    /// specified bundle. The rendered symbol may alter its appearance to
    /// represent the value provided in `variableValue`.
    ///
    /// - Parameters:
    ///   - name: The name of the image resource to lookup, as well as
    ///     the localization key with which to label the image.
    ///   - variableValue: An optional value between `0.0` and `1.0` that
    ///     the rendered image can use to customize its appearance, if
    ///     specified. If the symbol doesn't support variable values, this
    ///     parameter has no effect.
    ///   - bundle: The bundle to search for the image resource and
    ///     localization content. If `nil`, SkipUI uses the main
    ///     `Bundle`. Defaults to `nil`.
    ///
    public init(_ name: String, variableValue: Double?, bundle: Bundle? = nil) { fatalError() }

    /// Creates a labeled image that you can use as content for controls, with
    /// the specified label and variable value.
    ///
    /// This initializer creates an image using a using a symbol in the
    /// specified bundle. The rendered symbol may alter its appearance to
    /// represent the value provided in `variableValue`.
    ///
    /// - Parameters:
    ///   - name: The name of the image resource to lookup.
    ///   - variableValue: An optional value between `0.0` and `1.0` that
    ///     the rendered image can use to customize its appearance, if
    ///     specified. If the symbol doesn't support variable values, this
    ///     parameter has no effect.
    ///   - bundle: The bundle to search for the image resource. If
    ///     `nil`, SkipUI uses the main `Bundle`. Defaults to `nil`.
    ///   - label: The label associated with the image. SkipUI uses
    ///     the label for accessibility.
    ///
    public init(_ name: String, variableValue: Double?, bundle: Bundle? = nil, label: Text) { fatalError() }

    /// Creates an unlabeled, decorative image, with a variable value.
    ///
    /// This initializer creates an image using a using a symbol in the
    /// specified bundle. The rendered symbol may alter its appearance to
    /// represent the value provided in `variableValue`.
    ///
    /// SkipUI ignores this image for accessibility purposes.
    ///
    /// - Parameters:
    ///   - name: The name of the image resource to lookup.
    ///   - variableValue: An optional value between `0.0` and `1.0` that
    ///     the rendered image can use to customize its appearance, if
    ///     specified. If the symbol doesn't support variable values, this
    ///     parameter has no effect.
    ///   - bundle: The bundle to search for the image resource. If
    ///     `nil`, SkipUI uses the main `Bundle`. Defaults to `nil`.
    ///
    public init(decorative name: String, variableValue: Double?, bundle: Bundle? = nil) { fatalError() }
}

#if canImport(UIKit)
import struct UIKit.ImageResource

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension Image {

    /// Initialize an `Image` with an image resource.
    public init(_ resource: ImageResource) { fatalError() }
}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension Image {

    public struct DynamicRange : Hashable, Sendable {

        /// Restrict the image content dynamic range to the standard range.
        public static let standard: Image.DynamicRange = { fatalError() }()

        /// Allow image content to use some extended range. This is
        /// appropriate for placing HDR content next to SDR content.
        public static let constrainedHigh: Image.DynamicRange = { fatalError() }()

        /// Allow image content to use an unrestricted extended range.
        public static let high: Image.DynamicRange = { fatalError() }()

    
        

        }

    /// Returns a new image configured with the specified allowed
    /// dynamic range.
    ///
    /// The following example enables HDR rendering for a specific
    /// image view, assuming that the image has an HDR (ITU-R 2100)
    /// color space and the output device supports it:
    ///
    ///     Image("hdr-asset").allowedDynamicRange(.high)
    ///
    /// - Parameter range: the requested dynamic range, or nil to
    ///   restore the default allowed range.
    ///
    /// - Returns: a new image.
    public func allowedDynamicRange(_ range: Image.DynamicRange?) -> Image { fatalError() }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Image {

    /// Indicates whether SkipUI renders an image as-is, or
    /// by using a different mode.
    ///
    /// The ``TemplateRenderingMode`` enumeration has two cases:
    /// ``TemplateRenderingMode/original`` and ``TemplateRenderingMode/template``.
    /// The original mode renders pixels as they appear in the original source
    /// image. Template mode renders all nontransparent pixels as the
    /// foreground color, which you can use for purposes like creating image
    /// masks.
    ///
    /// The following example shows both rendering modes, as applied to an icon
    /// image of a green circle with darker green border:
    ///
    ///     Image("dot_green")
    ///         .renderingMode(.original)
    ///     Image("dot_green")
    ///         .renderingMode(.template)
    ///
    /// ![Two identically-sized circle images. The circle on top is green
    /// with a darker green border. The circle at the bottom is a solid color,
    /// either white on a black background, or black on a white background,
    /// depending on the system's current dark mode
    /// setting.](SkipUI-Image-TemplateRenderingMode-dots.png)
    ///
    /// You also use `renderingMode` to produce multicolored system graphics
    /// from the SF Symbols set. Use the ``TemplateRenderingMode/original``
    /// mode to apply a foreground color to all parts of the symbol except
    /// those that have a distinct color in the graphic. The following
    /// example shows three uses of the `person.crop.circle.badge.plus` symbol
    /// to achieve different effects:
    ///
    /// * A default appearance with no foreground color or template rendering
    /// mode specified. The symbol appears all black in light mode, and all
    /// white in Dark Mode.
    /// * The multicolor behavior achieved by using `original` template
    /// rendering mode, along with a blue foreground color. This mode causes the
    /// graphic to override the foreground color for distinctive parts of the
    /// image, in this case the plus icon.
    /// * A single-color template behavior achieved by using `template`
    /// rendering mode with a blue foreground color. This mode applies the
    /// foreground color to the entire image, regardless of the user's Appearance preferences.
    ///
    ///```swift
    ///HStack {
    ///    Image(systemName: "person.crop.circle.badge.plus")
    ///    Image(systemName: "person.crop.circle.badge.plus")
    ///        .renderingMode(.original)
    ///        .foregroundColor(.blue)
    ///    Image(systemName: "person.crop.circle.badge.plus")
    ///        .renderingMode(.template)
    ///        .foregroundColor(.blue)
    ///}
    ///.font(.largeTitle)
    ///```
    ///
    /// ![A horizontal layout of three versions of the same symbol: a person
    /// icon in a circle with a plus icon overlaid at the bottom left. Each
    /// applies a diffent set of colors based on its rendering mode, as
    /// described in the preceding
    /// list.](SkipUI-Image-TemplateRenderingMode-sfsymbols.png)
    ///
    /// Use the SF Symbols app to find system images that offer the multicolor
    /// feature. Keep in mind that some multicolor symbols use both the
    /// foreground and accent colors.
    ///
    /// - Parameter renderingMode: The mode SkipUI uses to render images.
    /// - Returns: A modified ``Image``.
    public func renderingMode(_ renderingMode: Image.TemplateRenderingMode?) -> Image { fatalError() }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Image {

    /// The orientation of an image.
    ///
    /// Many image formats such as JPEG include orientation metadata in the
    /// image data. In other cases, you can specify image orientation
    /// in code. Properly specifying orientation is often important both for
    /// displaying the image and for certain kinds of image processing.
    ///
    /// In SkipUI, you provide an orientation value when initializing an
    /// ``Image`` from an existing
    /// .
    @frozen public enum Orientation : UInt8, CaseIterable, Hashable {

        /// A value that indicates the original pixel data matches the image's
        /// intended display orientation.
        case up

        /// A value that indicates a horizontal flip of the image from the
        /// orientation of its original pixel data.
        case upMirrored

        /// A value that indicates a 180° rotation of the image from the
        /// orientation of its original pixel data.
        case down

        /// A value that indicates a vertical flip of the image from the
        /// orientation of its original pixel data.
        case downMirrored

        /// A value that indicates a 90° counterclockwise rotation from the
        /// orientation of its original pixel data.
        case left

        /// A value that indicates a 90° clockwise rotation and horizontal
        /// flip of the image from the orientation of its original pixel
        /// data.
        case leftMirrored

        /// A value that indicates a 90° clockwise rotation of the image from
        /// the orientation of its original pixel data.
        case right

        /// A value that indicates a 90° counterclockwise rotation and
        /// horizontal flip from the orientation of its original pixel data.
        case rightMirrored

        /// Creates a new instance with the specified raw value.
        ///
        /// If there is no value of the type that corresponds with the specified raw
        /// value, this initializer returns `nil`. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     print(PaperSize(rawValue: "Legal"))
        ///     // Prints "Optional("PaperSize.Legal")"
        ///
        ///     print(PaperSize(rawValue: "Tabloid"))
        ///     // Prints "nil"
        ///
        /// - Parameter rawValue: The raw value to use for the new instance.
        public init?(rawValue: UInt8) { fatalError() }

        /// A type that can represent a collection of all values of this type.
        public typealias AllCases = [Image.Orientation]

        /// The raw type that can be used to represent all values of the conforming
        /// type.
        ///
        /// Every distinct value of the conforming type has a corresponding unique
        /// value of the `RawValue` type, but there may be values of the `RawValue`
        /// type that don't have a corresponding value of the conforming type.
        public typealias RawValue = UInt8

        /// A collection of all values of this type.
        public static var allCases: [Image.Orientation] { get { fatalError() } }

        /// The corresponding value of the raw type.
        ///
        /// A new instance initialized with `rawValue` will be equivalent to this
        /// instance. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     let selectedSize = PaperSize.Letter
        ///     print(selectedSize.rawValue)
        ///     // Prints "Letter"
        ///
        ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
        ///     // Prints "true"
        public var rawValue: UInt8 { get { fatalError() } }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Image {

    /// A type that indicates how SkipUI renders images.
    public enum TemplateRenderingMode : Sendable {

        /// A mode that renders all non-transparent pixels as the foreground
        /// color.
        case template

        /// A mode that renders pixels of bitmap images as-is.
        ///
        /// For system images created from the SF Symbol set, multicolor symbols
        /// respect the current foreground and accent colors.
        case original

        

    
        }

    /// A scale to apply to vector images relative to text.
    ///
    /// Use this type with the ``View/imageScale(_:)`` modifier, or the
    /// ``EnvironmentValues/imageScale`` environment key, to set the image scale.
    ///
    /// The following example shows the three `Scale` values as applied to
    /// a system symbol image, each set against a text view:
    ///
    ///     HStack { Image(systemName: "swift").imageScale(.small); Text("Small") }
    ///     HStack { Image(systemName: "swift").imageScale(.medium); Text("Medium") }
    ///     HStack { Image(systemName: "swift").imageScale(.large); Text("Large") }
    ///
    /// ![Vertically arranged text views that read Small, Medium, and
    /// Large. On the left of each view is a system image that uses the Swift symbol.
    /// The image next to the Small text is slightly smaller than the text.
    /// The image next to the Medium text matches the size of the text. The
    /// image next to the Large text is larger than the
    /// text.](SkipUI-EnvironmentAdditions-Image-scale.png)
    ///
    @available(macOS 11.0, *)
    public enum Scale : Sendable {

        /// A scale that produces small images.
        case small

        /// A scale that produces medium-sized images.
        case medium

        /// A scale that produces large images.
        case large

        

    
        }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Image {

    /// The level of quality for rendering an image that requires interpolation,
    /// such as a scaled image.
    ///
    /// The ``Image/interpolation(_:)`` modifier specifies the interpolation
    /// behavior when using the ``Image/resizable(capInsets:resizingMode:)``
    /// modifier on an ``Image``. Use this behavior to prioritize rendering
    /// performance or image quality.
    public enum Interpolation : Sendable {

        /// A value that indicates SkipUI doesn't interpolate image data.
        case none

        /// A value that indicates a low level of interpolation quality, which may
        /// speed up image rendering.
        case low

        /// A value that indicates a medium level of interpolation quality,
        /// between the low- and high-quality values.
        case medium

        /// A value that indicates a high level of interpolation quality, which
        /// may slow down image rendering.
        case high

        

    
        }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Image {

    /// Specifies the current level of quality for rendering an
    /// image that requires interpolation.
    ///
    /// See the article <doc:Fitting-Images-into-Available-Space> for examples
    /// of using `interpolation(_:)` when scaling an ``Image``.
    /// - Parameter interpolation: The quality level, expressed as a value of
    /// the `Interpolation` type, that SkipUI applies when interpolating
    /// an image.
    /// - Returns: An image with the given interpolation value set.
    public func interpolation(_ interpolation: Image.Interpolation) -> Image { fatalError() }

    /// Specifies whether SkipUI applies antialiasing when rendering
    /// the image.
    /// - Parameter isAntialiased: A Boolean value that specifies whether to
    /// allow antialiasing. Pass `true` to allow antialising, `false` otherwise.
    /// - Returns: An image with the antialiasing behavior set.
    public func antialiased(_ isAntialiased: Bool) -> Image { fatalError() }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Image {

    /// Creates a labeled image based on a Core Graphics image instance, usable
    /// as content for controls.
    ///
    /// - Parameters:
    ///   - cgImage: The base graphical image.
    ///   - scale: The scale factor for the image,
    ///     with a value like `1.0`, `2.0`, or `3.0`.
    ///   - orientation: The orientation of the image. The default is
    ///     ``Image/Orientation/up``.
    ///   - label: The label associated with the image. SkipUI uses the label
    ///     for accessibility.
    public init(_ cgImage: CGImage, scale: CGFloat, orientation: Image.Orientation = .up, label: Text) { fatalError() }

    /// Creates an unlabeled, decorative image based on a Core Graphics image
    /// instance.
    ///
    /// SkipUI ignores this image for accessibility purposes.
    ///
    /// - Parameters:
    ///   - cgImage: The base graphical image.
    ///   - scale: The scale factor for the image,
    ///     with a value like `1.0`, `2.0`, or `3.0`.
    ///   - orientation: The orientation of the image. The default is
    ///     ``Image/Orientation/up``.
    public init(decorative cgImage: CGImage, scale: CGFloat, orientation: Image.Orientation = .up) { fatalError() }
}

#if canImport(UIKit)
import class UIKit.UIImage

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(macOS, unavailable)
extension Image {

    /// Creates a SkipUI image from a UIKit image instance.
    /// - Parameter uiImage: The UIKit image to wrap with a SkipUI ``Image``
    /// instance.
    public init(uiImage: UIImage) { fatalError() }
}
#endif

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension Image {

    /// Initializes an image of the given size, with contents provided by a
    /// custom rendering closure.
    ///
    /// Use this initializer to create an image by calling drawing commands on a
    /// ``GraphicsContext`` provided to the `renderer` closure.
    ///
    /// The following example shows a custom image created by passing a
    /// `GraphicContext` to draw an ellipse and fill it with a gradient:
    ///
    ///     let mySize = CGSize(width: 300, height: 200)
    ///     let image = Image(size: mySize) { context in
    ///         context.fill(
    ///             Path(
    ///                 ellipseIn: CGRect(origin: .zero, size: mySize)),
    ///                 with: .linearGradient(
    ///                     Gradient(colors: [.yellow, .orange]),
    ///                     startPoint: .zero,
    ///                     endPoint: CGPoint(x: mySize.width, y:mySize.height))
    ///         )
    ///     }
    ///
    /// ![An ellipse with a gradient that blends from yellow at the upper-
    /// left to orange at the bottom-right.](Image-2)
    ///
    /// - Parameters:
    ///   - size: The size of the newly-created image.
    ///   - label: The label associated with the image. SkipUI uses the label
    ///     for accessibility.
    ///   - opaque: A Boolean value that indicates whether the image is fully
    ///     opaque. This may improve performance when `true`. Don't render
    ///     non-opaque pixels to an image declared as opaque. Defaults to `false`.
    ///   - colorMode: The working color space and storage format of the image.
    ///     Defaults to ``ColorRenderingMode/nonLinear``.
    ///   - renderer: A closure to draw the contents of the image. The closure
    ///     receives a ``GraphicsContext`` as its parameter.
    public init(size: CGSize, label: Text? = nil, opaque: Bool = false, colorMode: ColorRenderingMode = .nonLinear, renderer: @escaping (inout GraphicsContext) -> Void) { fatalError() }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Image {

    /// The modes that SkipUI uses to resize an image to fit within
    /// its containing view.
    public enum ResizingMode : Sendable {

        /// A mode to repeat the image at its original size, as many
        /// times as necessary to fill the available space.
        case tile

        /// A mode to enlarge or reduce the size of an image so that it
        /// fills the available space.
        case stretch

        

    
        }

    /// Sets the mode by which SkipUI resizes an image to fit its space.
    /// - Parameters:
    ///   - capInsets: Inset values that indicate a portion of the image that
    ///   SkipUI doesn't resize.
    ///   - resizingMode: The mode by which SkipUI resizes the image.
    /// - Returns: An image, with the new resizing behavior set.
    public func resizable(capInsets: EdgeInsets = EdgeInsets(), resizingMode: Image.ResizingMode = .stretch) -> Image { fatalError() }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Image.Orientation : RawRepresentable {
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Image.Orientation : Sendable {
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Image.TemplateRenderingMode : Equatable {
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Image.TemplateRenderingMode : Hashable {
}

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 11.0, *)
extension Image.Scale : Equatable {
}

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 11.0, *)
extension Image.Scale : Hashable {
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Image.Interpolation : Equatable {
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Image.Interpolation : Hashable {
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Image.ResizingMode : Equatable {
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Image.ResizingMode : Hashable {
}

/// A shape style that fills a shape by repeating a region of an image.
///
/// You can also use ``ShapeStyle/image(_:sourceRect:scale:)`` to construct this
/// style.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct ImagePaint : ShapeStyle {

    /// The image to be drawn.
    public var image: Image { get { fatalError() } }

    /// A unit-space rectangle defining how much of the source image to draw.
    ///
    /// The results are undefined if this rectangle selects areas outside the
    /// `[0, 1]` range in either axis.
    public var sourceRect: CGRect { get { fatalError() } }

    /// A scale factor applied to the image while being drawn.
    public var scale: CGFloat { get { fatalError() } }

    /// Creates a shape-filling shape style.
    ///
    /// - Parameters:
    ///   - image: The image to be drawn.
    ///   - sourceRect: A unit-space rectangle defining how much of the source
    ///     image to draw. The results are undefined if `sourceRect` selects
    ///     areas outside the `[0, 1]` range in either axis.
    ///   - scale: A scale factor applied to the image during rendering.
    public init(image: Image, sourceRect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1), scale: CGFloat = 1) { fatalError() }

    /// The type of shape style this will resolve to.
    ///
    /// When you create a custom shape style, Swift infers this type
    /// from your implementation of the required `resolve` function.
    public typealias Resolved = Never
}

#if canImport(Combine)
import protocol Combine.ObservableObject
import class Combine.PassthroughSubject

/// An object that creates images from SkipUI views.
///
/// Use `ImageRenderer` to export bitmap image data from a SkipUI view. You
/// initialize the renderer with a view, then render images on demand,
/// either by calling the ``render(rasterizationScale:renderer:)`` method, or
/// by using the renderer's properties to create a
/// ,
/// , or
/// .
///
/// By drawing to a ``Canvas`` and exporting with an `ImageRenderer`,
/// you can generate images from any progammatically-rendered content, like
/// paths, shapes, gradients, and more. You can also render standard SkipUI
/// views like ``Text`` views, or containers of multiple view types.
///
/// The following example uses a private `createAwardView(forUser:date:)` method
/// to create a game app's view of a trophy symbol with a user name and date.
/// This view combines a ``Canvas`` that applies a shadow filter with
/// two ``Text`` views into a ``VStack``. A ``Button`` allows the person to
/// save this view. The button's action uses an `ImageRenderer` to rasterize a
/// `CGImage` and then calls a private `uploadAchievementImage(_:)` method to
/// encode and upload the image.
///
///     var body: some View {
///         let trophyAndDate = createAwardView(forUser: playerName,
///                                              date: achievementDate)
///         VStack {
///             trophyAndDate
///             Button("Save Achievement") {
///                 let renderer = ImageRenderer(content: trophyAndDate)
///                 if let image = renderer.cgImage {
///                     uploadAchievementImage(image)
///                 }
///             }
///         }
///     }
///
///     private func createAwardView(forUser: String, date: Date) -> some View {
///         VStack {
///             Image(systemName: "trophy")
///                 .resizable()
///                 .frame(width: 200, height: 200)
///                 .frame(maxWidth: .infinity, maxHeight: .infinity)
///                 .shadow(color: .mint, radius: 5)
///             Text(playerName)
///                 .font(.largeTitle)
///             Text(achievementDate.formatted())
///         }
///         .multilineTextAlignment(.center)
///         .frame(width: 200, height: 290)
///     }
///
/// ![A large trophy symbol, drawn with a mint-colored shadow. Below this, a
/// user name and the date and time. At the bottom, a button with the title
/// Save Achievement allows people to save and upload an image of this
/// view.](ImageRenderer-1)
///
/// Because `ImageRenderer` conforms to
/// , you
/// can use it to produce a stream of images as its properties change. Subscribe
/// to the renderer's ``ImageRenderer/objectWillChange`` publisher, then use the
/// renderer to rasterize a new image each time the subscriber receives an
/// update.
///
/// - Important: `ImageRenderer` output only includes views that SkipUI renders,
/// such as text, images, shapes, and composite views of these types. It
/// does not render views provided by native platform frameworks (AppKit and
/// UIKit) such as web views, media players, and some controls. For these views,
/// `ImageRenderer` displays a placeholder image, similar to the behavior of
/// ``View/drawingGroup(opaque:colorMode:)``.
///
/// ### Rendering to a PDF context
///
/// The ``render(rasterizationScale:renderer:)`` method renders the specified
/// view to any
/// . That
/// means you aren't limited to creating a rasterized `CGImage`. For
/// example, you can generate PDF data by rendering to a PDF context. The
/// resulting PDF maintains resolution-independence for supported members of the
/// view hierarchy, such as text, symbol images, lines, shapes, and fills.
///
/// The following example uses the `createAwardView(forUser:date:)` method from
/// the previous example, and exports its contents as an 800-by-600 point PDF to
/// the file URL `renderURL`. It uses the `size` parameter sent to the
/// rendering closure to center the `trophyAndDate` view vertically and
/// horizontally on the page.
///
///     var body: some View {
///         let trophyAndDate = createAwardView(forUser: playerName,
///                                             date: achievementDate)
///         VStack {
///             trophyAndDate
///             Button("Save Achievement") {
///                 let renderer = ImageRenderer(content: trophyAndDate)
///                 renderer.render { size, renderer in
///                     var mediaBox = CGRect(origin: .zero,
///                                           size: CGSize(width: 800, height: 600))
///                     guard let consumer = CGDataConsumer(url: renderURL as CFURL),
///                           let pdfContext =  CGContext(consumer: consumer,
///                                                       mediaBox: &mediaBox, nil)
///                     else {
///                         return
///                     }
///                     pdfContext.beginPDFPage(nil)
///                     pdfContext.translateBy(x: mediaBox.size.width / 2 - size.width / 2,
///                                            y: mediaBox.size.height / 2 - size.height / 2)
///                     renderer(pdfContext)
///                     pdfContext.endPDFPage()
///                     pdfContext.closePDF()
///                 }
///             }
///         }
///     }
///
/// ### Creating an image from drawing instructions
///
/// `ImageRenderer` makes it possible to create a custom image by drawing into a
/// ``Canvas``, rendering a `CGImage` from it, and using that to initialize an
/// ``Image``. To simplify this process, use the `Image`
/// initializer ``Image/init(size:label:opaque:colorMode:renderer:)``, which
/// takes a closure whose argument is a ``GraphicsContext`` that you can
/// directly draw into.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
final public class ImageRenderer<Content> : ObservableObject where Content : View {

    /// A publisher that informs subscribers of changes to the image.
    ///
    /// The renderer's
    /// publishes `Void` elements.
    /// Subscribers should interpret any event as indicating that the contents
    /// of the image may have changed.
    final public let objectWillChange: PassthroughSubject<Void, Never>

    /// The root view rendered by this image renderer.
    @MainActor final public var content: Content { get { fatalError() } }

    /// The size proposed to the root view.
    ///
    /// The default value of this property, ``ProposedViewSize/unspecified``,
    /// produces an image that matches the original view size. You can provide
    /// a custom ``ProposedViewSize`` to override the view's size in one or
    /// both dimensions.
    @MainActor final public var proposedSize: ProposedViewSize { get { fatalError() } }

    /// The scale at which to render the image.
    ///
    /// This value is a ratio of view points to image pixels. This relationship
    /// means that values greater than `1.0` create an image larger than the
    /// original content view, and less than `1.0` creates a smaller image. The
    /// following example shows a 100 x 50 rectangle view and an image rendered
    /// from it with a `scale` of `2.0`, resulting in an image size of
    /// 200 x 100.
    ///
    ///     let rectangle = Rectangle()
    ///         .frame(width: 100, height: 50)
    ///     let renderer = ImageRenderer(content: rectangle)
    ///     renderer.scale = 2.0
    ///     if let rendered = renderer.cgImage {
    ///         print("Scaled image: \(rendered.width) x \(rendered.height)")
    ///     }
    ///     // Prints "Scaled image: 200 x 100"
    ///
    /// The default value of this property is `1.0`.
    @MainActor final public var scale: CGFloat { get { fatalError() } }

    /// A Boolean value that indicates whether the alpha channel of the image is
    /// fully opaque.
    ///
    /// Setting this value to `true`, meaning the alpha channel is opaque, may
    /// improve performance. Don't render non-opaque pixels to a renderer
    /// declared as opaque. This property defaults to `false`.
    @MainActor final public var isOpaque: Bool { get { fatalError() } }

    /// The working color space and storage format of the image.
    @MainActor final public var colorMode: ColorRenderingMode { get { fatalError() } }

    /// Creates a renderer object with a source content view.
    ///
    /// - Parameter view: A ``View`` to render.
    @MainActor public init(content view: Content) { fatalError() }

    /// The current contents of the view, rasterized as a Core Graphics image.
    ///
    /// The renderer notifies its `objectWillChange` publisher when
    /// the contents of the image may have changed.
    @MainActor final public var cgImage: CGImage? { get { fatalError() } }

    #if canImport(UIKit)
    /// The current contents of the view, rasterized as a UIKit image.
    ///
    /// The renderer notifies its `objectWillChange` publisher when
    /// the contents of the image may have changed.
    @MainActor final public var uiImage: UIImage? { get { fatalError() } }
    #endif
    
    /// Draws the renderer's current contents to an arbitrary Core Graphics
    /// context.
    ///
    /// Use this method to rasterize the renderer's content to a
    /// you provide. The `renderer` closure receives two parameters: the current
    /// size of the view, and a function that renders the view to your
    /// `CGContext`. Implement the closure to provide a suitable `CGContext`,
    /// then invoke the function to render the content to that context.
    ///
    /// - Parameters:
    ///   - rasterizationScale: The scale factor for converting user
    ///     interface points to pixels when rasterizing parts of the
    ///     view that can't be represented as native Core Graphics drawing
    ///     commands.
    ///   - renderer: The closure that sets up the Core Graphics context and
    ///     renders the view. This closure receives two parameters: the size of
    ///     the view and a function that you invoke in the closure to render the
    ///     view at the reported size. This function takes a
    ///     
    ///     parameter, and assumes a bottom-left coordinate space origin.
    @MainActor final public func render(rasterizationScale: CGFloat = 1, renderer: (CGSize, (CGContext) -> Void) -> Void) { fatalError() }

    /// The type of publisher that emits before the object has changed.
    public typealias ObjectWillChangePublisher = PassthroughSubject<Void, Never>
}
#endif

#endif
