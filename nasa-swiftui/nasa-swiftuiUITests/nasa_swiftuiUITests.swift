//
//  nasa_swiftuiUITests.swift
//  nasa-swiftuiUITests
//
//  Created by Brynner Ventura on 7/20/23.
//

import XCTest

final class nasa_swiftuiUITests: XCTestCase {

    func testInitialAppState() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["NASA Image"].exists)
        XCTAssertTrue(app.sliders["Image Size Slider"].exists)
    }

    func testImageScaleUpWithSlider() throws {
        let app = XCUIApplication()
        app.launch()

        let sizeSlider = app.sliders["Image Size Slider"]
        let imageView = app.images.firstMatch

        // Verify the initial image appearance before adjusting the slider
        let initialImageSize = imageView.frame.size

        // Move the Slider to the right to increase the image size
        sizeSlider.adjust(toNormalizedSliderPosition: 1.0)

        // Wait for the image view to be updated
        sleep(5)

        // Get the updated image appearance after adjusting the slider
        let updatedImageSize = imageView.frame.size

        // Verify that the updated image appears larger than the initial image
        XCTAssertTrue(updatedImageSize.width > initialImageSize.width)
    }

}
