//
//  MapView.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 17.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import MapKit
import Cluster

final class MapView: UIView {

    // MARK: - Private properties

    private var mapView: MKMapView!
    private var manager: ClusterManager!
    private var mapViewDataProvider: MapViewDataProvider!

    private var showDetailsAction: ((Building) -> Void)?

    // MARK: - Initializers

    init(showDetailsAction: @escaping (Building) -> Void) {
        self.showDetailsAction = showDetailsAction
        super.init(frame: .zero)

        configureClusterManager()
        configureMapView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(withBuildings buildings: [Building]) {
        mapViewDataProvider = MapViewDataProvider(buildings: buildings)
        mapView.delegate = mapViewDataProvider
        mapViewDataProvider.delegate = self
        mapViewDataProvider.addAnnotations()
    }

    private func configureMapView() {
        mapView = MKMapView()
        mapView.pointOfInterestFilter = .excludingAll

        addSubview(mapView)

        mapView.pin(to: self)

        let region = (
            center: CLLocationCoordinate2D(
                latitude: Constants.Coordinates.kievLatitude,
                longitude: Constants.Coordinates.kievLongitude
            ),
            delta: 0.65
        )

        mapView.region = MKCoordinateRegion(
            center: region.center,
            span: MKCoordinateSpan(latitudeDelta: region.delta, longitudeDelta: region.delta)
        )
    }

    private func configureClusterManager() {
        manager = ClusterManager()
        manager.maxZoomLevel = 17
        manager.minCountForClustering = 3
        manager.clusterPosition = .average
    }

    // MARK: - Helpers
    
    func showAllAnnotations() {
        mapView.fitAll(mapViewDataProvider.annotations)
    }

}

    // MARK: - Extensions

    // MARK: - Map view delegate

extension MapView: MapViewDataProviderDelegate {

    func add(annotations: [IdentifableAnnotation]) {
        manager.add(annotations)
    }

    func reload() {
        manager.reload(mapView: mapView)
    }

    func showDetails(withBuilding building: Building) {
        showDetailsAction?(building)
    }

}
