/**
*  SVGPlugin plugin for Publish
*  Copyright (c) Mikhail Medvedev 2021
*  MIT license, see LICENSE file for details
**/

import enum Plot.Node

public protocol SVGFileNameCase: RawRepresentable {
	var rawValue: String { get }
}

public extension Node {
	///  `<svg>` Node
	///  You can add additional parameters like width/height and stylesheets classes.
	/// - Parameters:
	///   - fileName: Name of the file inside SVG-folder
	///   - parameters: SVGParameters
	/// - Returns: Node withHTMLContext
	static func svg(_ fileName: String, parameters: SVGAttribute...) -> Self {
		SVGFileManager.shared.svg(fileName, parameters: parameters)
	}

	///  `<svg>` Node
	///  You can add additional parameters like width/height and class.
	/// - Parameters:
	///   - fileName: case of enum, conformed to SVGFileNameCase protocol
	///   - parameters: SVGParameters
	/// - Returns: Node withHTMLContext
	static func svg<T: SVGFileNameCase>(_ fileName: T, parameters: SVGAttribute...) -> Self {
		SVGFileManager.shared.svg(fileName.rawValue, parameters: parameters)
	}
}
