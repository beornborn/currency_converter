# Currency Converter

## Look Leadfeederinterviewhomework.pdf for the task description

## Instruction for installation
1. Install MongoDB
2. Configure MongoDB in mongodb.yml
3. install bundler
4. run `bundle install`

## Usage
- sync database rates with external source by running `rake rates:sync`
- convert USD to EUR by running `rake convert[120,2016-04-21]`

