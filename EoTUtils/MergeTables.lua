function EOT_MergeTables(target, ...)
    for _, table in ipairs(arg) do
        for k, v in pairs(table) do target[k] = v end
    end
    return target
end
