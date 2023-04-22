//
//  SandboxViewController.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import TinkoffContest
import UIKit

final class SandboxViewController: UIViewController {

    private let scrollView = UIScrollView().forAutoLayout()
    private let contentView = UIView().forAutoLayout()
    private let stackView = UIStackView().forAutoLayout()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        contentView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        stackView.spacing = 8
        stackView.axis = .vertical

        NSLayoutConstraint.activate(
            [
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
                scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ]
        )

        stackView.addArrangedSubview(makeHeaderWithButton(colorStyle: .white))
        stackView.addArrangedSubview(makeHeaderWithButton(colorStyle: .grey))
        stackView.addArrangedSubview(makeHeaderWithTitleDescription(colorStyle: .white))
        stackView.addArrangedSubview(makeHeaderWithTitleDescription(colorStyle: .grey))
        stackView.addArrangedSubview(makeHeaderWithTitleDescription(colorStyle: .white))
        stackView.addArrangedSubview(makeHeaderWithTitleDescription(colorStyle: .grey))
        stackView.addArrangedSubview(makeButton())
        stackView.addArrangedSubview(makeLeftIconHeaderViewWithoutButton(colorStyle: .white))
        stackView.addArrangedSubview(makeLeftIconHeaderViewWithoutButton(colorStyle: .grey))
        stackView.addArrangedSubview(makeLeftIconHeaderViewWithButton())
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

        return header
    }

    private func makeButton() -> UIView {
        let button = TCSButton().forAutoLayout()
        button.setTitle("Button", for: .normal)
        button.didTapClosure = { print("didTap!") }
        return button
    }
}

