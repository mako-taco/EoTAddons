function EOT_MergeTables(target, ...)
    for _, table in ipairs(arg) do
        for k, v in pairs(table) do target[k] = v end
    end
    return target
end

function EOT_MergeITables(target, ...)
    for _, t in ipairs(arg) do
        for _, v in pairs(t) do table.insert(target, v) end
    end
    return target
end