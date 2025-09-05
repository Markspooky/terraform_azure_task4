tags = {
  Creator = "mark_nagy@epam.com"
}

resource_groups = {
  rg1 = {
    name     = "cmaz-zz733vvq-mod5-rg-01"
    location = "westeurope"
    tags     = { Creator = "mark_nagy@epam.com" }
  }
  rg2 = {
    name     = "cmaz-zz733vvq-mod5-rg-02"
    location = "northeurope"
    tags     = { Creator = "mark_nagy@epam.com" }
  }
  rg3 = {
    name     = "cmaz-zz733vvq-mod5-rg-03"
    location = "francecentral"
    tags     = { Creator = "mark_nagy@epam.com" }
  }
}

workloads = {
  w1 = {
    rg_key = "rg1"
    plan = {
      name         = "cmaz-zz733vvq-mod5-asp-01"
      sku_name     = "P0v3"
      worker_count = 2
    }
    app = {
      name = "cmaz-zz733vvq-mod5-app-01"
    }
  }
  w2 = {
    rg_key = "rg2"
    plan = {
      name         = "cmaz-zz733vvq-mod5-asp-02"
      sku_name     = "P1v3"
      worker_count = 1
    }
    app = {
      name = "cmaz-zz733vvq-mod5-app-02"
    }
  }
}


verification_ip = "18.153.146.156/32"


traffic_manager = {
  rg_key         = "rg3"
  name           = "cmaz-zz733vvq-mod5-traf"
  routing_method = "Performance"
}
