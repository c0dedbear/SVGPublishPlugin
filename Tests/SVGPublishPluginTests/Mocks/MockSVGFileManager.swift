/**
*  SVGPlugin plugin for Publish
*  Copyright (c) Mikhail Medvedev 2021
*  MIT license, see LICENSE file for details
**/

import struct Publish.Path
import Plot
import Foundation
@testable import enum SVGPublishPlugin.SVGAttribute
@testable import class SVGPublishPlugin.SVGFileManager

final class MockSVGFileManager {
	init() {}
	
	func svg(_ content: String, parameters: [SVGAttribute]) -> Node<Any> {
		return SVGFileManager.shared.svg(content, params: parameters)
	}
}
