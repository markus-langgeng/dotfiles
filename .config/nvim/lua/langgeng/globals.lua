P = function(v)
    print(vim.inspect(v))
    return v
end

Mtable = {
    { kesatu = 1 },
    { kedua = 2 }
}

-- Mtable[3] = { "ketiga", hahah = { hihi = "ahhah" } }
Mtable[3] = { "ketiga" }
Mtable[3].hahah = { hihi = "ahhah" }
