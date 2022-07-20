import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project Factory

protocol ProjectFactory {
    var projectName: String { get }
    var dependencies: [TargetDependency] { get }

    func generate() -> [Target]
}

// MARK: - Base Project Factory

class BaseProjectFactory: ProjectFactory {
    let projectName: String = "DailyChaCha"

    let dependencies: [TargetDependency] = [
        .package(product: "RIBs"),
        .package(product: "Moya"),
        .package(product: "RxMoya"),
        .package(product: "SnapKit"),
        .package(product: "SwiftyBeaver"),
        .package(product: "RxDataSources"),
        .package(product: "ReactorKit"),
        .package(product: "Then"),
        .package(product: "RxKeyboard"),
        .package(product: "Lottie"),
        .package(product: "BonMot"),
        .package(product: "RxAlert")
    ]
    
    let packages: [Package] = [
        .remote(url: "https://github.com/uber/RIBs.git", requirement: .upToNextMinor(from: "0.11.0")),
        .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMinor(from: "15.0.0")),
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMinor(from: "5.0.0")),
        .remote(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", requirement: .upToNextMinor(from: "1.9.0")),
        .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMinor(from: "6.5.0")),
        .remote(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", requirement: .upToNextMinor(from: "5.0.0")),
        .remote(url: "https://github.com/ReactorKit/ReactorKit.git", requirement: .upToNextMinor(from: "3.2.0")),
        .remote(url: "https://github.com/devxoul/Then.git", requirement: .upToNextMinor(from: "3.0.0")),
        .remote(url: "https://github.com/RxSwiftCommunity/RxKeyboard.git", requirement: .upToNextMinor(from: "2.0.0")),
        .remote(url: "https://github.com/airbnb/lottie-ios.git", requirement: .upToNextMinor(from: "3.3.0")),
        .remote(url: "https://github.com/Rightpoint/BonMot.git", requirement: .upToNextMinor(from: "6.1.1")),
        .local(path: .relativeToRoot("vendor/RxAlert"))
    ]

    func generate() -> [Target] {
        [
            Target(
                name: projectName,
                platform: .iOS,
                product: .app,
                bundleId: "com.dailychacha.\(projectName)",
                deploymentTarget: .iOS(targetVersion: "13.0", devices: [.iphone]),
                infoPlist: "\(projectName)/\(projectName)/Resources/Info.plist",
                sources: ["\(projectName)/\(projectName)/Sources/**"],
                resources: [
                    "\(projectName)/\(projectName)/**/*.storyboard",
                    "\(projectName)/\(projectName)/**/*.xib",
                    "\(projectName)/\(projectName)/**/*.xcassets",
                    "\(projectName)/\(projectName)/**/*.json",
                ],
                entitlements: "\(projectName)/\(projectName).entitlements",
                dependencies: dependencies
            ),

            Target(
                name: "\(projectName)Tests",
                platform: .iOS,
                product: .unitTests,
                bundleId: "com.dailychacha.\(projectName).Tests",
                infoPlist: .default,
                sources: ["\(projectName)/\(projectName)Tests/**"],
                dependencies: [.target(name: "DailyChaCha")]
            )
        ]
    }
}

// MARK: - Project

let factory = BaseProjectFactory()

let project: Project = .init(
    name: factory.projectName,
    organizationName: factory.projectName,
    packages: factory.packages,
    targets: factory.generate()
)
