function CitadelleRP.API:switch(n, ...)
  for _,v in ipairs {...} do
    if v[1] == n or v[1] == nil then
      return v[2]()
    end
  end
end

function CitadelleRP.API:case(n,f)
  return {n,f}
end

function CitadelleRP.API:default(f)
  return {nil,f}
end


function CitadelleRP.API:GetNumberOfEntries(T)

  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
  
end