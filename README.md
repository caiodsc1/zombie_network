## ZSSN (Zombie Survival Social Network)

[https://zombie-network.herokuapp.com](https://zombie-network.herokuapp.com/map)

## Installation

**Dependencies**: Before installation make sure you have PostgreSQL (9.5) and Ruby (2.4.5) installed. 

1. Clone the Project

	~~~ sh
	git clone https://github.com/caiodsc/survival_network.git
	~~~

2. Bundle

	~~~ sh
	bundle install
	~~~

3. Start the Application

	~~~ sh
	rails s
	~~~

	
## API Documentation

### Survivors

#### Create new survivor

POST /survivors
   
        {
            "name": "Caio", 
            "age": "23", 
            "gender": "male", 
            "inventory_attributes": {
                "water: 10    
                "food": 10
                ...
            }
            latitude: -3.123456
            longitude: -60.123456
        }
        

#### Update Survivor Location

PATCH /survivors/:id

        {
            "latitude": -3.123456,
            "longitude": -60.123456
        }

            
### Infection Alerts

#### Report Infection

POST /report_infection

        {
            "survivor_one": 17,
            "survivor_two": 35
        }



### Trades

#### Trade resources 

POST /trades

        {
            "survivor_one": 17,
            "survivor_two": 35,
            "resources_one": {
                water: 10,
                food: 5
            },
            "resources_two": {
                medication: 20,
                ammunition: 15
            }
        }

            
### Details

#### Percent of Infected Survivors

GET /infected_survivors


#### Percent of Not Infected Survivors

GET /not_infected_survivors

#### Average resources per Survivor

GET /average_resources
            
#### Points lost due Infected Survivors

GET /points_lost

## Testing with RSpec

1. Run tests

    ~~~ sh
    rspec
    ~~~
    
    