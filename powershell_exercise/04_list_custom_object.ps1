#list of custom objects
$employees = @(
    [PSCustomObject]@{Name = "Alice"; Age = 45; Role = "Manager"}
    [PSCustomObject]@{Name = "John"; Age = 25; Role = "Developer"}
    [PSCustomObject]@{Name = "Bob"; Age = 28; Role = "Tester"}
)

#Iterate through a list of custom objects
foreach ($i in $employees)
{
    "$($i.Name) $($i.Age), $($i.Role)"
}