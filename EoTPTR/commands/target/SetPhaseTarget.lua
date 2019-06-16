local unlearn = {
  {
    25300,
    31016,
    25347,
    25302,
    25297,
    25299,
    31018,
    25298,
    25316,
    25315,
    25314,
    25286,
    25289,
    25288,
    25306,
    25304,
    25345,
    25296,
    25295,
    25294,
    25307,
    25309,
    25311,
    25361,
    29228,
    25357,
    25359,
  }
}

function EOT_SetPhaseTarget(phase)
  for i,v in ipairs(unlearn[phase]) do
    EOT_RunCommand("unlearn", v)
  end
end