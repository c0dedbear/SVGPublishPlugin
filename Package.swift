// swift-tools-version:5.4

/**
*  SVGPlugin plugin for Publish
*  Copyright (c) Mikhail Medvedev 2021
*  MIT license, see LICENSE file for details
**/

import PackageDescription

let package = Package(
    name: "SVGPublishPlugin",
    products: [
        .library(
            name: "SVGPublishPlugin",
            targets: ["SVGPublishPlugin"]
		)
    ],
    dependencies: [
		.package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.8.0"),
		.package(url: "https://github.com/c0dedbear/StrongTypedCSSPublishPlugin", from: "0.1.1")
    ],
    targets: [
		.target(
            name: "SVGPublishPlugin",
			dependencies: ["Publish", "StrongTypedCSSPublishPlugin"]
		),
        .testTarget(
            name: "SVGPublishPluginTests",
            dependencies: ["SVGPublishPlugin"],
			resources: [
				.process("Mocks/test.svg")
			]
		)
    ]
)
