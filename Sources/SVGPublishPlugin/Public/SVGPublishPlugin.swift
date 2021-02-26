/**
*  SVGPlugin plugin for Publish
*  Copyright (c) Mikhail Medvedev 2021
*  MIT license, see LICENSE file for details
**/

import Publish

public extension Plugin {
	static func svgPlugin(folderPath: Path = "Resources/svg") throws -> Self {
		Plugin(name: "SVGPlugin") { context in
			guard let files = try? context.folder(at: folderPath).files else {
				throw PublishingError(stepName: "Search for svg files folder 💬",
									  infoMessage: "🔴 Folder with svg files not found at '\(folderPath.string)'")
			}

			let svgs = files.filter({ $0.extension == "svg" })

			guard svgs.count > 0 else {
				throw PublishingError(stepName: "Search for svg files 💬",
									  infoMessage: "🔴 There are no .svg files found in '\(folderPath.string)'")
			}

			try svgs.forEach {
				guard let contents = try? $0.readAsString() else {
					throw PublishingError(stepName: "Caching svg file's content 💬",
										  infoMessage: "🔴 Can't read \($0.name) as String")
				}

				SVGFileManager.shared.cache(fileName: $0.nameExcludingExtension, with: contents)
			}
		}
	}
}
