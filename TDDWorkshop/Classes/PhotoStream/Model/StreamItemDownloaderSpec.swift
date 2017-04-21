import Quick
import Nimble

@testable
import TDDWorkshop

class StreamItemDownloaderSpec: QuickSpec {
    override func spec() {
        describe("StreamItemDownloader") {

            var sut: StreamItemDownloader!
            

            beforeEach {
                sut = StreamItemDownloader(parseAdapter: DefaultParseAdapter()) //TODO fix me!
            }

            describe("download items") {

                var downloadedItems: [StreamItem]?
                var capturedError: Error?

                beforeEach {
                    sut.downloadItems {
                        items, error in
                        downloadedItems = items
                        capturedError = error
                    }
                }

                it("should execute query") {
                    
                }
                it("should execute query to fetch StreamItem") {
                }

                context("when succeeds and completion is called") {
                    beforeEach {
                    }
                    it("should NOT pass error") {
                        expect(capturedError).to(beNil())
                    }
                    it("should return stream items") {
                        expect(downloadedItems).notTo(beNil())
                    }
                    it("should return single stream item") {
                        expect(downloadedItems!.count) == 1
                    }
                    it("should parse correctly title of the item") {
                        let streamItem = downloadedItems![0]
                        expect(streamItem.title) == "Foo"
                    }
                }
                context("when fails") {
                    beforeEach {
                    }
                    it("should pass an error") {
                        expect(capturedError).notTo(beNil())
                    }
                    it("should NOT return stream items") {
                        expect(downloadedItems).to(beNil())
                    }
                }
            }
        }
    }
}
