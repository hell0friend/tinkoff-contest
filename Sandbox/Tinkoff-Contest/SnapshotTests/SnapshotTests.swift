//
//  SnapshotTests.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import SnapshotTesting
import TinkoffContest
import XCTest

final class SnapshotTests: XCTestCase {

    private enum Constants {
        static let xsSize: CGFloat = 60.0 * 60.0
        static let sSize: CGFloat = 100.0 * 100.0
        static let mSize: CGFloat = 150.0 * 150.0
        static let lSize: CGFloat = 200.0 * 200.0
        static let snapshotFolderName = "__Snapshots__"
        static let snapshotTests = "SnapshotTests"
        static let width: CGFloat = 375
    }

    func testDesignSystem() {
        let testableViews: [String: UIView] = [
            "HorizontalItemContainerViewWithButton": makeHorizontalItemContainerViewWithButton(),
            "HorizontalItemContainerViewWithoutButton": makeHorizontalItemContainerViewWithoutButton(),
            "HeaderWithTitleDescriptionWhite": makeHeaderWithTitleDescription(colorStyle: .white),
            "HeaderWithTitleDescriptionGrey": makeHeaderWithTitleDescription(colorStyle: .grey),
            "HeaderWithTitleWhite": makeHeaderWithTitle(colorStyle: .white),
            "HeaderWithTitleGrey": makeHeaderWithTitle(colorStyle: .grey),
            "HeaderWithButtonWhite": makeHeaderWithButton(colorStyle: .white),
            "HeaderWithButtonGrey": makeHeaderWithButton(colorStyle: .grey),
            "LeftIconHeaderViewWithoutButtonWhite": makeLeftIconHeaderViewWithoutButton(colorStyle: .white),
            "LeftIconHeaderViewWithoutButtonGrey": makeLeftIconHeaderViewWithoutButton(colorStyle: .grey),
            "LeftIconHeaderViewWithButton": makeLeftIconHeaderViewWithButton(),
            "VerticalItemContainerViewWithButtonWhite": makeVerticalItemContainerViewWithButton(backgroundStyle: .white),
            "VerticalItemContainerViewWithButtonGrey": makeVerticalItemContainerViewWithButton(backgroundStyle: .grey),
            "VerticalItemContainerViewWithoutButtonWhite": makeVerticalItemContainerViewWithoutButton(backgroundStyle: .white),
            "VerticalItemContainerViewWithoutButtonGrey": makeVerticalItemContainerViewWithoutButton(backgroundStyle: .grey)
        ]

        runAllTests(
            directory: Self.createSnapshotDirectoryPath(from: #file),
            testableViews: testableViews
        )
    }

    private func makeHorizontalItemContainerViewWithButton() -> UIView {
        let view = HorizontalItemContainerView().forAutoLayout()

        view.configure(
            with: HorizontalItemContainerView.ViewModel(
                title: "Long long long long long long long long header",
                topButtonConfiguration: .init(text: "Button", didTap: { print("did tap top button!") }),
                bottomButtonConfiguration: .init(text: "Button", didTap: { print("did tap bottom button!") }),
                items: [
                    HorizontalItemView.ViewModel(
                        icon: UIImage(named: "tui-avatar") ?? UIImage(),
                        title: "Long long long long long header",
                        description: "Long long long long long description",
                        didSelect: { print("didSelect item 0") }
                    ),
                    HorizontalItemView.ViewModel(
                        icon: UIImage(named: "tui-avatar") ?? UIImage(),
                        title: "Long long long long long header",
                        description: "Long long long long long description",
                        didSelect: { print("didSelect item 1") }
                    ),
                    HorizontalItemView.ViewModel(
                        icon: UIImage(named: "tui-avatar") ?? UIImage(),
                        title: "Long long long long long header",
                        description: "Long long long long long description",
                        didSelect: { print("didSelect item 2") }
                    ),
                    HorizontalItemView.ViewModel(
                        icon: UIImage(named: "tui-avatar") ?? UIImage(),
                        title: "Long long long long long header",
                        description: "Long long long long long description",
                        didSelect: { print("didSelect item 3") }
                    )
                ]
            )
        )

        view.widthAnchor.constraint(equalToConstant: Constants.width).isActive = true

        return view
    }

    private func makeHorizontalItemContainerViewWithoutButton() -> UIView {
        let view = HorizontalItemContainerView().forAutoLayout()

        view.configure(
            with: HorizontalItemContainerView.ViewModel(
                title: "Long long long long long long long long header",
                topButtonConfiguration: .init(text: "Button", didTap: { print("did tap top button!") }),
                bottomButtonConfiguration: nil,
                items: [
                    HorizontalItemView.ViewModel(
                        icon: UIImage(named: "tui-avatar") ?? UIImage(),
                        title: "Long long long long long header",
                        description: "Long long long long long description",
                        didSelect: { print("didSelect item 0") }
                    ),
                    HorizontalItemView.ViewModel(
                        icon: UIImage(named: "tui-avatar") ?? UIImage(),
                        title: "Long long long long long header",
                        description: "Long long long long long description",
                        didSelect: { print("didSelect item 1") }
                    ),
                    HorizontalItemView.ViewModel(
                        icon: UIImage(named: "tui-avatar") ?? UIImage(),
                        title: "Long long long long long header",
                        description: "Long long long long long description",
                        didSelect: { print("didSelect item 2") }
                    ),
                    HorizontalItemView.ViewModel(
                        icon: UIImage(named: "tui-avatar") ?? UIImage(),
                        title: "Long long long long long header",
                        description: "Long long long long long description",
                        didSelect: { print("didSelect item 3") }
                    )
                ]
            )
        )

        view.widthAnchor.constraint(equalToConstant: Constants.width).isActive = true

        return view
    }

    private func makeHeaderWithTitleDescription(colorStyle: BackgroundStyle) -> UIView {
        let header = RightIconHeaderView().forAutoLayout()

        header.configure(
            with: RightIconHeaderView.ViewModel(
                state: .titleAndDescription(
                    title: "Long long long long long header",
                    description: "Long long long long long description"
                ),
                icon: UIImage(named: "tui-avatar") ?? UIImage(),
                backgroundStyle: colorStyle
            )
        )

        header.widthAnchor.constraint(equalToConstant: Constants.width).isActive = true

        return header
    }

    private func makeHeaderWithTitle(colorStyle: BackgroundStyle) -> UIView {
        let header = RightIconHeaderView().forAutoLayout()

        header.configure(
            with: RightIconHeaderView.ViewModel(
                state: .title("Long long long long long header"),
                icon: UIImage(named: "tui-avatar") ?? UIImage(),
                backgroundStyle: colorStyle
            )
        )

        header.widthAnchor.constraint(equalToConstant: Constants.width).isActive = true

        return header
    }

    private func makeHeaderWithButton(colorStyle: BackgroundStyle) -> UIView {
        let header = RightIconHeaderView().forAutoLayout()

        header.configure(
            with: RightIconHeaderView.ViewModel(
                state: .button(
                    title: "Long long long long long header",
                    description: "Long long long long long description",
                    buttonText: "Button",
                    buttonAction: { print("didTap!") }
                ),
                icon: UIImage(named: "tui-avatar") ?? UIImage(),
                backgroundStyle: colorStyle
            )
        )

        header.widthAnchor.constraint(equalToConstant: Constants.width).isActive = true

        return header
    }

    private func makeLeftIconHeaderViewWithoutButton(colorStyle: BackgroundStyle) -> UIView {
        let header = LeftIconHeaderView().forAutoLayout()

        header.configure(
            with: LeftIconHeaderView.ViewModel(
                title: "Long long long long long header",
                description: "Long long long long long description",
                icon: UIImage(named: "tui-avatar") ?? UIImage(),
                closeStyle: .none(colorStyle)
            )
        )

        header.widthAnchor.constraint(equalToConstant: Constants.width).isActive = true

        return header
    }

    private func makeLeftIconHeaderViewWithButton() -> UIView {
        let header = LeftIconHeaderView().forAutoLayout()

        header.configure(
            with: LeftIconHeaderView.ViewModel(
                title: "Long long long long long header",
                description: "Long long long long long description",
                icon: UIImage(named: "tui-avatar") ?? UIImage(),
                closeStyle: .action(
                    didClose: { print("didClose!") },
                    image: UIImage(named: "tui-button") ?? UIImage()
                )
            )
        )

        header.widthAnchor.constraint(equalToConstant: Constants.width).isActive = true

        return header
    }

    private func makeVerticalItemContainerViewWithButton(backgroundStyle: BackgroundStyle) -> UIView {
        let view = VerticalItemContainerView().forAutoLayout()
        view.configure(
            with: VerticalItemContainerView.ViewModel(
                title: "Long long long long long long long long header",
                backgroundStyle: backgroundStyle,
                topButtonConfiguration: .init(text: "Button", didTap: { print("did tap top button!") }),
                bottomButtonConfiguration: .init(text: "Bottom Button", didTap: { print("did tap bottom button!") }),
                items: [
                    VerticalItemView.ViewModel(
                        icon: UIImage(named: "tui-avatar") ?? UIImage(),
                        title: "Long long long long long long long long header",
                        description: "Long long long long long description",
                        didSelect: { print("didSelect item 0") }
                    ),
                    VerticalItemView.ViewModel(
                        icon: UIImage(named: "tui-avatar") ?? UIImage(),
                        title: "Long long long long long header",
                        description: "Long long long long long description",
                        didSelect: { print("didSelect item 1") }
                    ),
                    VerticalItemView.ViewModel(
                        icon: UIImage(named: "tui-avatar") ?? UIImage(),
                        title: "Long long long long long header",
                        description: "Long long long long long description",
                        didSelect: { print("didSelect item 2") }
                    )
                ]
            )
        )
        view.widthAnchor.constraint(equalToConstant: Constants.width).isActive = true
        return view
    }

    private func makeVerticalItemContainerViewWithoutButton(backgroundStyle: BackgroundStyle) -> UIView {
        let view = VerticalItemContainerView().forAutoLayout()
        view.configure(
            with: VerticalItemContainerView.ViewModel(
                title: "Long long long long long long long long header",
                backgroundStyle: backgroundStyle,
                topButtonConfiguration: .init(text: "Button", didTap: { print("did tap top button!") }),
                bottomButtonConfiguration: nil,
                items: [
                    VerticalItemView.ViewModel(
                        icon: UIImage(named: "tui-avatar") ?? UIImage(),
                        title: "Long long long long long long long long header",
                        description: "Long long long long long description",
                        didSelect: { print("didSelect item 0") }
                    ),
                    VerticalItemView.ViewModel(
                        icon: UIImage(named: "tui-avatar") ?? UIImage(),
                        title: "Long long long long long header",
                        description: "Long long long long long description",
                        didSelect: { print("didSelect item 1") }
                    ),
                    VerticalItemView.ViewModel(
                        icon: UIImage(named: "tui-avatar") ?? UIImage(),
                        title: "Long long long long long header",
                        description: "Long long long long long description",
                        didSelect: { print("didSelect item 2") }
                    )
                ]
            )
        )
        view.widthAnchor.constraint(equalToConstant: Constants.width).isActive = true
        return view
    }

    private func runAllTests(directory: String, testableViews: [String: UIView]) {
        for (name, testableView) in testableViews {
            let result = verifySnapshot(
                matching: testableView,
                as: .image(precision: Self.precisionForView(frame: testableView.frame)),
                named: "light",
                snapshotDirectory: directory,
                testName: name
            )
            XCTAssertNil(result)
        }
    }

    private static func precisionForView(frame rect: CGRect) -> Float {
        switch rect.width * rect.height {
        case 0 ..< Constants.xsSize:
            return 0.88
        case Constants.xsSize ..< Constants.sSize:
            return 0.91
        case Constants.sSize ..< Constants.mSize:
            return 0.94
        case Constants.mSize ..< Constants.lSize:
            return 0.96
        case Constants.lSize ... CGFloat.infinity:
            return 0.99
        default:
            return 0.0
        }
    }

    private static func createSnapshotDirectoryPath(from file: StaticString) -> String {
        let path = file.withUTF8Buffer {
            String(decoding: $0, as: UTF8.self)
        }
        var components = path.components(separatedBy: "/")
        if !components.isEmpty {
            components.removeLast()
        }

        guard let index = components.lastIndex(of: Constants.snapshotTests) else {
            assertionFailure("Тесты лежат не в папке " + Constants.snapshotTests)
            return String()
        }

        components.insert(Constants.snapshotFolderName, at: index + 1)

        return components.reduce("", { $0 + $1 + "/" })
    }
}
