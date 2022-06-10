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
      .external(name: "RIBs"),
      .external(name: "Moya"),
      .external(name: "SnapKit"),
      .external(name: "SwiftyBeaver"),
      .external(name: "RxDataSources"),
      .external(name: "ReactorKit")
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
    targets: factory.generate()
)
