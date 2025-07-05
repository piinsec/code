#create custom object (obj has properties)
$person = [PSCustomObject]@{
    FirstName = "John"
    LastName = "Doe"
    Age = 30
    Occupation = "Software Developer"
}

"Full Name : $($person.FirstName) $($person.LastName)"