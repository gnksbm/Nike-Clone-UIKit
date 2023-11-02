import ProjectDescription

let projectName = "NikeKit"
let orgName = "https://github.com/gnksbm/NikeKit"
let bundleID = "com.nikeclonekit"
let infoPlist: [String: InfoPlist.Value] = [
    "BundleDisplayName": "NikeKit",
    "BundleShortVersionString": "1.0",
    "BundleVersion": "1.0.0",
    "UILaunchStoryboardName": "LaunchScreen",
    "UIApplicationSceneManifest": [
        "UIApplicationSupportsMultipleScenes": false,
        "UISceneConfigurations": [
            "UIWindowSceneSessionRoleApplication": [
                [
                    "UISceneConfigurationName": "Default Configuration",
                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                ],
            ]
        ]
    ],
]
    
let project = Project(
    name: projectName,
    organizationName: orgName,
    packages: [
    ],
    targets: [
        .init(
            name: projectName,
            platform: .iOS,
            product: .app,
            bundleId: bundleID,
            deploymentTarget: .iOS(targetVersion: "16.4", devices: .iphone),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["\(projectName)/Sources/**"],
            resources: ["\(projectName)/Resources/**"],
            scripts: [
                .pre(path: "Scripts/SwiftLintRunScript.sh",
                     arguments: [],
                     name: "SwiftLint",
                     basedOnDependencyAnalysis: false),
            ],
            dependencies: [
            ]
        )
    ]
)
