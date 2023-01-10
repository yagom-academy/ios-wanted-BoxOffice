extension Collection {
    subscript(safe index: Index) -> Element? {
        let isElementExist = (startIndex..<endIndex).contains(index)
        return isElementExist ? self[index] : nil
    }
}
