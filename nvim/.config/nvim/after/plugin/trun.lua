local present, trun = pcall(require, "trun")

if not present then
    return
end

trun.setup()
