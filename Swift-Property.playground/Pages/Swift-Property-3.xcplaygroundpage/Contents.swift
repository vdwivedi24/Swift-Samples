struct TV {
  var height: Double
  var width: Double
  
  var diagonal: Int {
    let result = (height * height + width * width).squareRoot().rounded()
    return Int(result)
  }
}

let tv = TV(height: 15.7, width: 28)
tv.diagonal // 32
