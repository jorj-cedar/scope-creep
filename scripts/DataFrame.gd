extends Resource
class_name DataFrame

@export var data: Array
@export var columns: PackedStringArray

static func New(d: Array, c: PackedStringArray) -> DataFrame:
	var df = DataFrame.new()
	
	df.data = d
	if c:
		df.columns = c
		
	return df
	
func GetColumn(col: String):
	assert(col in columns)
	
	var ix = columns.find(col)
	var result = []
	
	for row in data:
		result.append(row[ix])
	
	return result
	
func GetRow(i: int):
	assert(i < len(data))
	return[i]
	
func AddColumn(d: Array, col_name: String):
	assert(len(d) == len(data))
	
	for i in range((len(data))):
		data[i].append(d[i])
	
	columns.append(col_name)	
	
	
func _to_string():
	if len(data) == 0:
		return "<empty DataFrame>"
	
	var result = "|".join(columns) + "\n"
	
	for row in data:
		result += "|".join(row) + "\n"
		
	
	return result
	
		
