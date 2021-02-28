/**
*  SVGPlugin plugin for Publish
*  Copyright (c) Mikhail Medvedev 2021
*  MIT license, see LICENSE file for details
**/

import Foundation.NSUUID

@testable import Publish
@testable import Plot
@testable import Files

// MARK: - Stub website
struct MockSite: Website {
	enum SectionID: String, WebsiteSectionID {
		case posts
	}

	struct ItemMetadata: WebsiteItemMetadata {}

	var url = URL(string: "https://stub.com")!
	var name = "Stub"
	var description = "description"
	var language: Language { .english }
	var imagePath: Path? { nil }
}

// MARK: - Temporary folder
extension Folder {
	static func createTemporary() throws -> Self {
		let parent = try createTestsFolder()
		return try parent.createSubfolder(named: UUID().uuidString)
	}

	func createCleanSubfolder(named: String) throws -> Folder {
		try? subfolder(named: named).delete()
		return try createSubfolder(named: named)
	}

	private static func createTestsFolder() throws -> Self {
		try Folder.temporary.createSubfolderIfNeeded(at: "SVGPublishPluginTests")
	}
}
