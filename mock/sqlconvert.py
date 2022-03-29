OUT_FILE = 'aggregate.sql'
TABLES = [
	'property',
	'person',
	'pet',
	'pay_card',
	'venmo',
	'ach',
	'apartment',
	'prop_amenity',
	'apt_amenity',
	'visited',
	'prev_addr',
	'renter_info',
	'lease',
	'pet_on_lease',
	'person_on_lease'
]


def csv_to_sql(table: str, csv_data, out_fw):
	with open(csv_data, mode='r', buffering=1) as csv:
		line = csv.readline() # Block out the header
		out_fw.write(f"-- TABLE: {table}\n-- (Schema: {line})\n")
		while (line := csv.readline()):
			out_fw.write(
				f"insert into {table} values({line[:-1]});\n"
			)
		out_fw.write("\n\n\n")
		
def convert():
	with open(OUT_FILE, mode='a') as out:
		for table in TABLES:
			in_file = table + '.csv'
			csv_to_sql(table, in_file, out)

def test():
	with open(OUT_FILE, mode='a') as out:
		csv_to_sql('test', 'Renter Info.csv', out)

if __name__ == "__main__":
	convert()
	# test()