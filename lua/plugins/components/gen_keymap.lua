return function(name)
    return function(keys, action, desc)
        return {
            keys,
            action,
            noremap = true,
            silent = true,
            desc = name .. ": " .. desc
        }
    end
end
