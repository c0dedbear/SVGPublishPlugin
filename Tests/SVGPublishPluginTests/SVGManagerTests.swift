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
@testable import enum SVGPublishPlugin.SVGAttribute

final class SVGManagerTests: XCTestCase {

	private let rawSVG = """
	<?xml version="1.0" encoding="iso-8859-1"?>
	<!-- Generator: Adobe Illustrator 18.1.1, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
	<svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
		 viewBox="0 0 53.355 53.355" style="enable-background:new 0 0 53.355 53.355;" xml:space="preserve">
	<g>
		<g>
			<circle style="fill:#010002;" cx="26.677" cy="4.383" r="4.383"/>
			<path style="fill:#010002;" d="M40.201,28.096c-1.236-13.887-7.854-16.657-7.854-16.657s-6.396-3.845-13.129,1.052
				c-4.365,3.973-5.373,10.038-6.063,15.896c-0.349,2.977,4.307,2.941,4.653,0c0.412-3.496,1-7.008,2.735-9.999l-0.008,3.375
				l-0.032,16.219v12.867c0,1.383,1.014,2.506,2.438,2.506c1.423,0,2.578-1.123,2.578-2.506V32.457h2.278c0,4.309,0,14.144,0,18.451
				c0,3,4.652,3,4.652,0c0-4.309,0-8.619,0-12.927l0.197-16.251c0.002-1.551,0.004-2.937,0.004-3.901
				c1.859,3.046,2.473,6.664,2.896,10.265C35.895,31.037,40.55,31.073,40.201,28.096z"/>
		</g>
	</g>
	</svg>
"""

	func testSVGWithoutParameters() {
		let mock = MockSVGFileManager()
		let node = mock.svg(rawSVG, parameters: [])
		XCTAssertEqual(node.render(), rawSVG)

	}

	func testSVGWithParameter() {
		let mock = MockSVGFileManager()
		let node = mock.svg(rawSVG, parameters: [.classString("test")])
		XCTAssert(node.render().contains("<svg class=\"test\" "))
	}

	func testSVGWithParameters() {
		let mock = MockSVGFileManager()
		let node = mock.svg(rawSVG, parameters: [.classString("test"), .width(12)])
		print(node.render())
		XCTAssert(node.render().contains("<svg width=\"12\" class=\"test\" "))
	}

	static var allTests = [
		("testExample",
		 testSVGWithoutParameters,
		 testSVGWithParameter,
		 testSVGWithParameters)
	]
}