/**
*  SVGPlugin plugin for Publish
*  Copyright (c) Mikhail Medvedev 2021
*  MIT license, see LICENSE file for details
**/

import XCTest
@testable import Publish
@testable import Plot
@testable import Files
@testable import SVGPublishPlugin

final class SVGPublishPluginTests: XCTestCase {

	func testNoThrowWithSVGAtDefaultFolderPath() {
		XCTAssertNoThrow(try publishWebsite(hasSVGInside: true))
	}

	func testThrowWithNoSVGAtDefaultFolderPath() {
		XCTAssertThrowsError(try publishWebsite(hasSVGInside: false))
	}

	func testThrowWithEmptyFolderPath() {
		XCTAssertThrowsError(try publishWebsite(svgFolderPath: .empty, hasSVGInside: true))
	}

	func testNoThrowWithCustomFolderPath() {
		XCTAssertNoThrow(try publishWebsite(svgFolderPath: .custom, hasSVGInside: true))
	}

	static var allTests = [
		("testExample",
		 testNoThrowWithSVGAtDefaultFolderPath,
		 testThrowWithNoSVGAtDefaultFolderPath,
		 testThrowWithEmptyFolderPath,
		 testNoThrowWithCustomFolderPath)
	]
}

private extension SVGPublishPluginTests {
	enum FolderPath: String {
		case `default` = "svg"
		case custom = "custom"
		case empty = ""
	}

	func publishWebsite(svgFolderPath: FolderPath = .default, hasSVGInside: Bool) throws {
		let fm = FileManager()
		let svgURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("Mocks/test.svg")

		let siteFolder = try Folder.createTemporary()
		let _ = try siteFolder.createCleanSubfolder(named: "Content")
		let svgFolder = try siteFolder.createCleanSubfolder(named: "Resources").createSubfolder(named: svgFolderPath.rawValue)

		if hasSVGInside {
			try fm.copyItem(at: svgURL, to: svgFolder.url.appendingPathComponent("test.svg"))
		}

		try MockSite().publish(
			withTheme: .foundation,
			at: Path(siteFolder.path),
			plugins: [
				.svgPlugin(folderPath: Path("Resources/" + svgFolderPath.rawValue)),
			]
		)

		// deleting temporary site folder
		try siteFolder.delete()
	}
}
