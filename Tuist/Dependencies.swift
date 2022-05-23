import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: .init(
        [
            .remote(url: "https://github.com/uber/RIBs.git", requirement: .upToNextMinor(from: "0.11.0")),
            .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMinor(from: "15.0.0")),
            .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMinor(from: "5.0.0")),
            .remote(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", requirement: .upToNextMinor(from: "1.9.0")),
            .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMinor(from: "6.5.0")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", requirement: .upToNextMinor(from: "5.0.0")),
            .remote(url: "https://github.com/ReactorKit/ReactorKit.git", requirement: .upToNextMinor(from: "3.2.0"))
        ]
    ),
    platforms: [.iOS]
)
