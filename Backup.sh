#!/bin/sh
rm -fr TestApp
kubectl cp app-prod:static ./TestApp
kubectl cp app-prod:templates ./TestApp