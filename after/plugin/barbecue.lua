local status, barbecue = pcall(require, "barbecue")
if not status then
    print("barbecue is not installed")
    return
end

barbecue.setup()
