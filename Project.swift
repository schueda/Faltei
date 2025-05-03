import ProjectDescription

let project = Project(
    name: "Faltei",
    targets: [
        .target(
            name: "Faltei",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.Faltei",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Faltei/Sources/**"],
            resources: ["Faltei/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "FalteiTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.FalteiTests",
            infoPlist: .default,
            sources: ["Faltei/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Faltei")]
        ),
    ]
)

