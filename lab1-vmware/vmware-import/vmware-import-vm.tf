provider "vsphere" {
  user           = "administrator@vsphere.local" #var.vsphere_user
  password       = "Hit@2022" #var.vsphere_password
  vsphere_server = "172.20.10.132" #var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "DC1"
}

data "vsphere_datastore" "datastore" {
  name          = "ds-sg"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "AZ1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = "DEV2"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  # only if you DO NOT want to wait for an IP address
  wait_for_guest_net_routable = false

  num_cpus = 2
  memory   = 2048
  #guest_id = "other3xLinux64Guest"

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 16
    thin_provisioned = false
  }
}