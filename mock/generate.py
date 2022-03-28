from typing import List
import pycurl
import certifi
import random
from datetime import timedelta
from io import BytesIO

# Config
MOCKAROO = "https://api.mockaroo.com/api/"
API_KEY: str = ""
API_PARAM = "?key=" + API_KEY

PROP_COUNT = 2
APT_COUNT = 10
LEASE_COUNT = 5
PERSON_COUNT = 10
PET_COUNT = 3
CARD_COUNT = 3
ACH_COUNT = 10
VENMO_COUNT = 2

if LEASE_COUNT > APT_COUNT:
	exit('Leases offered are greater than # of apartments. Please check config')

class Apartment:
	def __init__(self, data: str):
		sep = data.split(sep=",")
		self.prop_id = sep[0]
		self.apt = sep[1]
		# self.square_footage = sep[2]
		# self.bed_count = sep[3]
		# self.bath_count = sep[4]
		self.rent = sep[5]

# Initial Starting Amenities: [Amenity Name, Min Cost, Max Cost]
propAmenityList = [
	['Parking', 20, 80],
	['Swimming Pool', 10, 60],
	['Gym', 20, 50],
	['City Shuttle', 10, 30]
]

aptAmenityList = [
	['In-house Laundry', 20, 40],
	['TV+Cable Included', 20, 50],
	['Balcony', 20, 40],
	['Furnished', 50, 90],
]

curl = pycurl.Curl()

def retrieveData(schema: str, **kwargs) -> str:
	endpoint = MOCKAROO + schema + API_PARAM
	for k, v in kwargs.items():
		endpoint += "&" + (k) + "=" + str(v)

	buffer = BytesIO()

	curl.setopt(curl.URL, endpoint)
	curl.setopt(curl.WRITEDATA, buffer)
	curl.setopt(pycurl.SSL_VERIFYHOST, 0)
	curl.setopt(pycurl.SSL_VERIFYPEER, 0)   
	curl.perform()

	return buffer.getvalue().decode('iso-8859-1')

def writeFile(filename: str, data):
	with open(filename, 'w') as f:
		f.write(data)

def genData(filename: str, schema: str, **kwargs):
	data = retrieveData(schema, **kwargs)
	writeFile(filename, data)

def makeString(*args):
	string = ""
	for i in args:
		string += str(i) + ","
	return string[:-1] # Removes the last comma


def generate():
	# Data is generated in order of least dependent relations
	# Primitives
	genData("property.csv", "8ac165c0", count=PROP_COUNT)
	genData("person.csv", "d41211e0", count=PERSON_COUNT)
	genData("pet.csv", "f8298b90", count=PET_COUNT)
	genData("pay_card.csv", "42551840", count=CARD_COUNT, person_count=PERSON_COUNT)
	genData("ach.csv", "d8cc21a0", count=ACH_COUNT, person_count=PERSON_COUNT)
	genData("venmo.csv", "5d5a4450", count=VENMO_COUNT, person_count=PERSON_COUNT)


	# Apartments (Need to know which apartment #s to assign to other FKs)
	aptData = retrieveData("98cd9330", count=APT_COUNT, prop_count=PROP_COUNT)
	writeFile("apartment.csv", aptData)
	aptDataEach = aptData.split(sep="\n")[1:-1]
	# Store all apts locally
	apts = []
	for i in aptDataEach:
		apts.append(Apartment(i))

	print("Apartment Count: ", len(apts))


	# Amenities (Not Mockaroo)
	propAmenitiesData = ""
	for i in range(1, PROP_COUNT + 1):
		rint = random.randint(1, len(propAmenityList))
		amenities = random.sample(propAmenityList, rint)
		for  amenity in amenities:
			datum = makeString(
				'DEFAULT', 
				i,
				amenity[0],
				random.randint(amenity[1], amenity[2])
			)
			propAmenitiesData += datum + "\n"
	writeFile("prop_amenity.csv", propAmenitiesData)
	
	aptAmenitiesData = ""
	for apt in apts:
		rint = random.randint(0, len(aptAmenityList) - 1)
		amenities = random.sample(aptAmenityList, rint)
		for amenity in amenities:
			datum = makeString(
				'DEFAULT', 
				apt.prop_id,
				apt.apt,
				amenity[0],
				random.randint(amenity[1], amenity[2])
			)
			aptAmenitiesData += datum + "\n"
	writeFile("apt_amenity.csv", aptAmenitiesData)


	# Visited
	visitedData = ""
	for i in range(1, PERSON_COUNT + 1):
		rint = random.randint(0, 3)
		visitApts: List[Apartment] = random.sample(apts, rint)
		for apt in visitApts:
			randomDate = retrieveData("a3526f60", count=1)[:-1]
			datum = makeString(
				i,
				randomDate,
				apt.prop_id,
				apt.apt,
			)
			visitedData += datum + "\n"
	writeFile("visited.csv", visitedData)


	genData("prev_addr.csv", "83abf170", count=int(PERSON_COUNT * 1.25), person_count=PERSON_COUNT)
	genData("renter_info.csv", "bce9b270", count=int(PERSON_COUNT / 2), person_count=PERSON_COUNT)

	
	# Lease (Details)
	random.shuffle(apts)
	leaseData = ""
	for i in range(1, LEASE_COUNT + 1):
		apt: Apartment = apts[i]
		randomDate = retrieveData("a3526f60", count=1)[:-1]
		datum = makeString(
			i,
			apt.prop_id,
			apt.apt,
			randomDate,
			random.randint(1, 5) * 6,
			apt.rent
		)
		leaseData += datum + "\n"
	writeFile('lease.csv', leaseData)

	petLeaseData = ""
	petLeases = random.sample(list(range(LEASE_COUNT)), PET_COUNT)
	for i in range(1, PET_COUNT + 1):
		datum = makeString(
			petLeases[i - 1],
			i,
			1
		)
		petLeaseData += datum + "\n"
	writeFile('pet_on_lease.csv', petLeaseData)

	personLeaseData = ""
	people = random.sample(list(range(PERSON_COUNT)), LEASE_COUNT)
	for i in range(1, LEASE_COUNT + 1):
		datum = makeString(
			i,
			people[i - 1],
			1
		)
		personLeaseData += datum + "\n"
	writeFile('person_on_lease.csv', personLeaseData)


if (__name__=="__main__"):
	generate()