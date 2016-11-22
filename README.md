# CollectionUtils
Make local arrays and server json easy to dif and manage. 

Example
```
class TestDif:Diffable, CustomStringConvertible
{
    var id:String
    init( _ id:String )
    {
        self.id = id
    }
    
    var description:String
    {
        return "<TestDif> id: \(self.id)"
    }
}

let local  = [TestDif("1"), TestDif("2"),TestDif("3"),TestDif("4")]
let server = [TestDif("1"), TestDif("2"),TestDif("6"),TestDif("4"), TestDif("7")]
let dif = local.diff(serverList: server)

print(dif.create.map($0.id)) // ["6", "7"]
print(dif.update.map($0.id)) // ["1", "2", "4"]
print(dif.delete.map($0.id)) // ["3"]
```
