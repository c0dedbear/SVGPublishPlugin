# SVGPublishPlugin

[![Tests](https://github.com/c0dedbear/SVGPublishPlugin/actions/workflows/tests.yml/badge.svg)](https://github.com/c0dedbear/SVGPublishPlugin/actions/workflows/tests.yml)
![Swift 5.3](https://img.shields.io/badge/Swift-5.3-orange.svg)<a href="https://swift.org/package-manager">
<img src="https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
</a>![Mac](https://img.shields.io/badge/platforms-mac-brightgreen.svg?style=flat)<a href="https://github.com/JohnSundell/Publish">
<img src="https://img.shields.io/badge/Publish-Plugin-orange.svg?style=flat" alt="Publish Plugin" />
</a>

Use pure SVG files in your Publish projects💥

## Installation

Add the package to your SPM dependencies.

```swift
.package(name: "SVGPublishPlugin", url: "https://github.com/c0dedbear/SVGPublishPlugin", from: "0.1.0"),
```

## Usage

1. Put your .svg files at the **"Resources/svg"** folder (it's default path, but you can changed it).
2. Install the plugin using publishing pipeline like this:
```
​```swift
import SVGPublishPlugin
...
try YourWebSite().publish(
	withTheme: .bearlogsTheme,
	additionalSteps: [
...
	],
	plugins: [
		.svgPlugin(),
...
	]
)

```
☝Note that if your svg files not placed  in the **"Resources/svg"**, you must use '**folderPath**' parameter of '**.svgPlugin**' method. 
⚠️ There must be at least one file with .svg extension, in other case publish will throw an error on the install plugin step. 

3.  Use within **.svg** node like this:
```swift
// Note that you don't need import plugin in places where you build your HTML

func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
	HTML(
		.lang(context.site.language),
		.head(for: page, on: context.site),
		.body(
			.header(for: context, selectedSection: nil),
			.a(
			   .class(CSS.footerSectionTitle),
			   // Note that file`rss.svg` placed on folder path typed when installing plugin.
			   .svg("rss"),
			   .text("RSS feed"),
			   .href(Path.defaultForRSSFeed),
			)
		)
	)
}
```

4. Also you can put it additional parameters right into your svg file:

```swift
...
.svg("rss", parameters: .class(CSS.FooterRssIcon), .width(20), .height(20)),
...
```

.**width** and height - size of svg into pixels. 
.**classString** - stylesheet's class name string
.**class** - StrongTypedCSS conformed class (see more on <a href="https://github.com/c0dedbear/StrongTypedCSSPublishPlugin">https://github.com/c0dedbear/StrongTypedCSSPublishPlugin</a>)
.**clasees** - array of  StrongTypedCSS-conformed cases

5. For a more convenience usage, I recommend to create an enum conformed to **SVGFileNameCase** protocol,  which contains names of the svg files in your folder. And use it this way:

```swift
...
import SVGPublishPlugin
....
enum SVG: String, SVGFileNameCase {
	case logo
	case search
	case rss
	case backToTop
}

// Inside of any HTML Node:
...
.svg(SVG.logo, parameters: .class(CSS.logoForFeaturedPosts)),
...

```

# Author
<img src="authorlogo.png" alt="logo"/> Mikhail Medvedev | http://bearlogs.ru

