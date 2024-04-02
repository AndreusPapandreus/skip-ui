// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import Foundation

public struct DismissAction {
    let action: () -> Void

    static let `default` = DismissAction(action: { })

    public func callAsFunction() {
        action()
    }
}

public struct OpenURLAction {
    public struct Result {
        let rawValue: Int
        let url: URL?

        init (rawValue: Int, url: URL? = nil) {
            self.rawValue = rawValue
            self.url = url
        }

        public static let handled = Result(rawValue: 0)
        public static let discarded = Result(rawValue: 1)
        public static let systemAction = Result(rawValue: 2)
        public static func systemAction(_ url: URL) -> Result {
            return Result(rawValue: 2, url: url)
        }
    }

    let handler: (URL) -> Result
    let systemHandler: ((URL) throws -> Void)?

    static let `default`: OpenURLAction = OpenURLAction(handler: { _ in Result.systemAction })

    public init(handler: @escaping (URL) -> Result) {
        self.handler = handler
        self.systemHandler = nil
    }

    public init(handler: @escaping (URL) -> Result, systemHandler: @escaping (URL) throws -> Void) {
        self.handler = handler
        self.systemHandler = systemHandler
    }

    public func callAsFunction(_ url: URL) {
        callAsFunction(url, completion: { _ in })
    }

    public func callAsFunction(_ url: URL, completion: @escaping (_ accepted: Bool) -> Void) {
        let result = handler(url)
        if result.rawValue == Result.handled.rawValue {
            completion(true)
        } else if result.rawValue == Result.discarded.rawValue {
            completion(false)
        } else if result.rawValue == Result.systemAction.rawValue {
            if let systemHandler {
                let openURL = result.url ?? url
                do {
                    try systemHandler(openURL)
                } catch {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
}

#if false

// TODO: Process for use in SkipUI

/// An action that presents a window.
///
/// Use the ``EnvironmentValues/openWindow`` environment value to get the
/// instance of this structure for a given ``Environment``. Then call the
/// instance to open a window. You call the instance directly because it
/// defines a ``OpenWindowAction/callAsFunction(id:)`` method that Swift calls
/// when you call the instance.
///
/// For example, you can define a button that opens a new mail viewer
/// window:
///
///     @main
///     struct Mail: App {
///         var body: some Scene {
///             WindowGroup(id: "mail-viewer") {
///                 MailViewer()
///             }
///         }
///     }
///
///     struct NewViewerButton: View {
///         @Environment(\.openWindow) private var openWindow
///
///         var body: some View {
///             Button("Open new mail viewer") {
///                 openWindow(id: "mail-viewer")
///             }
///         }
///     }
///
/// You indicate which scene to open by providing one of the following:
///  * A string identifier that you pass through the `id` parameter,
///    as in the above example.
///  * A `value` parameter that has a type that matches the type that
///    you specify in the scene's initializer.
///  * Both an identifier and a value. This enables you to define
///    multiple window groups that take input values of the same type, like a
///    .
///
/// Use the first option to target either a ``WindowGroup`` or a
/// ``Window`` scene in your app that has a matching identifier. For a
/// `WindowGroup`, the system creates a new window for the group. If
/// the window group presents data, the system provides the default value
/// or `nil` to the window's root view. If the targeted scene is a
/// `Window`, the system orders it to the front.
///
/// Use the other two options to target a `WindowGroup` and provide
/// a value to present. If the interface already has a window from
/// the group that's presenting the specified value, the system brings the
/// window to the front. Otherwise, the system creates a new window and
/// passes a binding to the specified value.
@available(iOS 16.0, macOS 13.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct OpenWindowAction {

    /// Opens a window defined by a window group that presents the type of
    /// the specified value.
    ///
    /// Don't call this method directly. SkipUI calls it when you
    /// call the ``EnvironmentValues/openWindow`` action with a value:
    ///
    ///     openWindow(value: message.id)
    ///
    /// For information about how Swift uses the `callAsFunction()` method to
    /// simplify call site syntax, see
    /// [Methods with Special Names](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID622)
    /// in *The Swift Programming Language*.
    ///
    /// - Parameter value: The value to present.
    public func callAsFunction<D>(value: D) where D : Decodable, D : Encodable, D : Hashable { fatalError() }

    /// Opens a window that's associated with the specified identifier.
    ///
    /// Don't call this method directly. SkipUI calls it when you
    /// call the ``EnvironmentValues/openWindow`` action with an identifier:
    ///
    ///     openWindow(id: "message")
    ///
    /// For information about how Swift uses the `callAsFunction()` method to
    /// simplify call site syntax, see
    /// [Methods with Special Names](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID622)
    /// in *The Swift Programming Language*.
    ///
    /// - Parameter id: The identifier of the scene to present.
    public func callAsFunction(id: String) { fatalError() }

    /// Opens a window defined by the window group that presents the specified
    /// value type and that's associated with the specified identifier.
    ///
    /// Don't call this method directly. SkipUI calls it when you
    /// call the ``EnvironmentValues/openWindow`` action with an identifier
    /// and a value:
    ///
    ///     openWindow(id: "message", value: message.id)
    ///
    /// For information about how Swift uses the `callAsFunction()` method to
    /// simplify call site syntax, see
    /// [Methods with Special Names](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID622)
    /// in *The Swift Programming Language*.
    ///
    /// - Parameters:
    ///   - id: The identifier of the scene to present.
    ///   - value: The value to present.
    public func callAsFunction<D>(id: String, value: D) where D : Decodable, D : Encodable, D : Hashable { fatalError() }
}

/// An action that initiates a refresh operation.
///
/// When the ``EnvironmentValues/refresh`` environment value contains an
/// instance of this structure, certain built-in views in the corresponding
/// ``Environment`` begin offering a refresh capability. They apply the
/// instance's handler to any refresh operation that the user initiates.
/// By default, the environment value is `nil`, but you can use the
/// ``View/refreshable(action:)`` modifier to create and store a new
/// refresh action that uses the handler that you specify:
///
///     List(mailbox.conversations) { conversation in
///         ConversationCell(conversation)
///     }
///     .refreshable {
///         await mailbox.fetch()
///     }
///
/// On iOS and iPadOS, the ``List`` in the example above offers a
/// pull to refresh gesture because it detects the refresh action. When
/// the user drags the list down and releases, the list calls the action's
/// handler. Because SkipUI declares the handler as asynchronous, it can
/// safely make long-running asynchronous calls, like fetching network data.
///
/// ### Refreshing custom views
///
/// You can also offer refresh capability in your custom views.
/// Read the ``EnvironmentValues/refresh`` environment value to get the
/// `RefreshAction` instance for a given ``Environment``. If you find
/// a non-`nil` value, change your view's appearance or behavior to offer
/// the refresh to the user, and call the instance to conduct the
/// refresh. You can call the refresh instance directly because it defines
/// a ``RefreshAction/callAsFunction()`` method that Swift calls
/// when you call the instance:
///
///     struct RefreshableView: View {
///         @Environment(\.refresh) private var refresh
///
///         var body: some View {
///             Button("Refresh") {
///                 Task {
///                     await refresh?()
///                 }
///             }
///             .disabled(refresh == nil)
///         }
///     }
///
/// Be sure to call the handler asynchronously by preceding it
/// with `await`. Because the call is asynchronous, you can use
/// its lifetime to indicate progress to the user. For example,
/// you might reveal an indeterminate ``ProgressView`` before
/// calling the handler, and hide it when the handler completes.
///
/// If your code isn't already in an asynchronous context, create a
///  for the
/// method to run in. If you do this, consider adding a way for the
/// user to cancel the task. For more information, see
/// [Concurrency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)
/// in *The Swift Programming Language*.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct RefreshAction : Sendable {

    /// Initiates a refresh action.
    ///
    /// Don't call this method directly. SkipUI calls it when you
    /// call the ``RefreshAction`` structure that you get from the
    /// ``Environment``:
    ///
    ///     struct RefreshableView: View {
    ///         @Environment(\.refresh) private var refresh
    ///
    ///         var body: some View {
    ///             Button("Refresh") {
    ///                 Task {
    ///                     await refresh?()  // Implicitly calls refresh.callAsFunction()
    ///                 }
    ///             }
    ///             .disabled(refresh == nil)
    ///         }
    ///     }
    ///
    /// For information about how Swift uses the `callAsFunction()` method to
    /// simplify call site syntax, see
    /// [Methods with Special Names](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID622)
    /// in *The Swift Programming Language*.
    /// For information about asynchronous operations in Swift, see
    /// [Concurrency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html).
    public func callAsFunction() async { fatalError() }
}

/// An action that activates a standard rename interaction.
///
/// Use the ``View/renameAction(_:)-6lghl`` modifier to configure the rename
/// action in the environment.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public struct RenameAction {

    /// Triggers the standard rename action provided through the environment.
    public func callAsFunction() { fatalError() }
}

/// A button that triggers a standard rename action.
///
/// A rename button receives its action from the environment. Use the
/// ``View/renameAction(_:)-6lghl`` modifier to set the action. The
/// system disables the button if you don't define an action.
///
///     struct RowView: View {
///         @State private var text = ""
///         @FocusState private var isFocused: Bool
///
///         var body: some View {
///             TextField(text: $item.name) {
///                 Text("Prompt")
///             }
///             .focused($isFocused)
///             .contextMenu {
///                 RenameButton()
///                 // ... your own custom actions
///             }
///             .renameAction { $isFocused = true }
///     }
///
/// When someone taps the rename button in the context menu, the rename
/// action focuses the text field by setting the `isFocused`
/// property to true.
///
/// You can use this button inside of a navigation title menu and the
/// navigation title modifier automatically configures the environment
/// with the appropriate rename action.
///
///     ContentView()
///         .navigationTitle($contentTitle) {
///             // ... your own custom actions
///             RenameButton()
///         }
///
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public struct RenameButton<LabelX> : View where LabelX : View {

    /// Creates a rename button.
    public init() where LabelX == Label /*<Text, Image>*/ { fatalError() }

    @MainActor public var body: some View { get { return stubView() } }

//    public typealias Body = some View
}

/// An action that can end a search interaction.
///
/// Use the ``EnvironmentValues/dismissSearch`` environment value to get the
/// instance of this structure for a given ``Environment``. Then call the
/// instance to dismiss the current search interaction. You call the instance
/// directly because it defines a ``DismissSearchAction/callAsFunction()``
/// method that Swift calls when you call the instance.
///
/// When you dismiss search, SkipUI:
///
/// * Sets ``EnvironmentValues/isSearching`` to `false`.
/// * Clears any text from the search field.
/// * Removes focus from the search field.
///
/// > Note: Calling this instance has no effect if the user isn't
/// interacting with a search field.
///
/// Use this action to dismiss a search operation based on
/// another user interaction. For example, consider a searchable
/// view with a ``Button`` that presents more information about the first
/// matching item from a collection:
///
///     struct ContentView: View {
///         @State private var searchText = ""
///
///         var body: some View {
///             NavigationStack {
///                 SearchedView(searchText: searchText)
///                     .searchable(text: $searchText)
///             }
///         }
///     }
///
///     struct SearchedView: View {
///         var searchText: String
///
///         let items = ["a", "b", "c"]
///         var filteredItems: [String] { items.filter { $0 == searchText.lowercased() } }
///
///         @State private var isPresented = false
///         @Environment(\.dismissSearch) private var dismissSearch
///
///         var body: some View {
///             if let item = filteredItems.first {
///                 Button("Details about \(item)") {
///                     isPresented = true
///                 }
///                 .sheet(isPresented: $isPresented) {
///                     NavigationStack {
///                         DetailView(item: item, dismissSearch: dismissSearch)
///                     }
///                 }
///             }
///         }
///     }
///
/// The button becomes visible only after the user enters search text
/// that produces a match. When the user taps the button, SkipUI shows
/// a sheet that provides more information about the item, including
/// an Add button for adding the item to a stored list of items:
///
///     private struct DetailView: View {
///         var item: String
///         var dismissSearch: DismissSearchAction
///
///         @Environment(\.dismiss) private var dismiss
///
///         var body: some View {
///             Text("Information about \(item).")
///                 .toolbar {
///                     Button("Add") {
///                         // Store the item here...
///
///                         dismiss()
///                         dismissSearch()
///                     }
///                 }
///         }
///     }
///
/// People can dismiss the sheet by dragging it down, effectively
/// canceling the operation, leaving the in-progress search interaction
/// intact. Alternatively, people can tap the Add button to store the item.
/// Because the person using your app is likely to be done with both the
/// detail view and the search interaction at this point, the button's
/// closure also uses the ``EnvironmentValues/dismiss`` property to dismiss
/// the sheet, and the ``EnvironmentValues/dismissSearch`` property to
/// reset the search field.
///
/// > Important: Access the action from inside the searched view, as the
///   example above demonstrates, rather than from the searched view’s
///   parent, or another hierarchy, like that of a sheet. SkipUI sets the
///   value in the environment of the view that you apply the searchable
///   modifier to, and doesn’t propagate the value up the view hierarchy.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct DismissSearchAction {

    /// Dismisses the current search operation, if any.
    ///
    /// Don't call this method directly. SkipUI calls it for you when you
    /// call the ``DismissSearchAction`` structure that you get from the
    /// ``Environment``:
    ///
    ///     struct SearchedView: View {
    ///         @Environment(\.dismissSearch) private var dismissSearch
    ///
    ///         var body: some View {
    ///             Button("Cancel") {
    ///                 dismissSearch() // Implicitly calls dismissSearch.callAsFunction()
    ///             }
    ///         }
    ///     }
    ///
    /// For information about how Swift uses the `callAsFunction()` method to
    /// simplify call site syntax, see
    /// [Methods with Special Names](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID622)
    /// in *The Swift Programming Language*.
    public func callAsFunction() { fatalError() }
}

/// An action that dismisses a window associated to a particular scene.
///
/// Use the ``EnvironmentValues/dismissWindow`` environment value to get the
/// instance of this structure for a given ``Environment``. Then call the
/// instance to dismiss a window. You call the instance directly because it
/// defines a ``DismissWindowAction/callAsFunction(id:)`` method that Swift
/// calls when you call the instance.
///
/// For example, you can define a button that closes an auxiliary window:
///
///     @main
///     struct MyApp: App {
///         var body: some Scene {
///             WindowGroup {
///                 ContentView()
///             }
///             #if os(macOS)
///             Window("Auxiliary", id: "auxiliary") {
///                 AuxiliaryContentView()
///             }
///             #endif
///         }
///     }
///
///     struct DismissWindowButton: View {
///         @Environment(\.dismissWindow) private var dismissWindow
///
///         var body: some View {
///             Button("Close Auxiliary Window") {
///                 dismissWindow(id: "auxiliary")
///             }
///         }
///     }
@available(iOS 17.0, macOS 14.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct DismissWindowAction {

    /// Dismisses the current window.
    ///
    /// Don't call this method directly. SkipUI calls it when you
    /// call the ``EnvironmentValues/dismissWindow`` action:
    ///
    ///     dismissWindow()
    ///
    /// For information about how Swift uses the `callAsFunction()` method to
    /// simplify call site syntax, see
    /// [Methods with Special Names](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations#Methods-with-Special-Names)
    /// in *The Swift Programming Language*.
    public func callAsFunction() { fatalError() }

    /// Dismisses the window that's associated with the specified identifier.
    ///
    /// When the specified identifier represents a ``WindowGroup``, all of the
    /// open windows in that group will be dismissed. For dismissing a single
    /// window associated to a `WindowGroup` scene, use
    /// ``dismissWindow(value:)`` or ``dismissWindow(id:value:)``.
    ///
    /// Don't call this method directly. SkipUI calls it when you
    /// call the ``EnvironmentValues/dismissWindow`` action with an identifier:
    ///
    ///     dismissWindow(id: "message")
    ///
    /// For information about how Swift uses the `callAsFunction()` method to
    /// simplify call site syntax, see
    /// [Methods with Special Names](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations#Methods-with-Special-Names)
    /// in *The Swift Programming Language*.
    ///
    /// - Parameter id: The identifier of the scene to dismiss.
    public func callAsFunction(id: String) { fatalError() }

    /// Dismisses the window defined by the window group that is presenting the
    /// specified value type.
    ///
    /// If multiple windows match the provided value, then they all will be
    /// dismissed. For dismissing a specific window in a specific group, use
    /// ``dismissWindow(id:value:)``.
    ///
    /// Don't call this method directly. SkipUI calls it when you
    /// call the ``EnvironmentValues/dismissWindow`` action with an identifier
    /// and a value:
    ///
    ///     dismissWindow(value: message.id)
    ///
    /// For information about how Swift uses the `callAsFunction()` method to
    /// simplify call site syntax, see
    /// [Methods with Special Names](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations#Methods-with-Special-Names)
    /// in *The Swift Programming Language*.
    ///
    /// - Parameters:
    ///   - value: The value which is currently presented.
    public func callAsFunction<D>(value: D) where D : Decodable, D : Encodable, D : Hashable { fatalError() }

    /// Dismisses the window defined by the window group that is presenting the
    /// specified value type and that's associated with the specified identifier.
    ///
    /// Don't call this method directly. SkipUI calls it when you
    /// call the ``EnvironmentValues/dismissWindow`` action with an identifier
    /// and a value:
    ///
    ///     dismissWindow(id: "message", value: message.id)
    ///
    /// For information about how Swift uses the `callAsFunction()` method to
    /// simplify call site syntax, see
    /// [Methods with Special Names](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations#Methods-with-Special-Names)
    /// in *The Swift Programming Language*.
    ///
    /// - Parameters:
    ///   - id: The identifier of the scene to dismiss.
    ///   - value: The value which is currently presented.
    public func callAsFunction<D>(id: String, value: D) where D : Decodable, D : Encodable, D : Hashable { fatalError() }
}

#endif
