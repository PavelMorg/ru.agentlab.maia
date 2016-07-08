/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

import java.util.Queue;

import javax.inject.Inject;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLAxiom;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLOntology;
import org.semanticweb.owlapi.model.OWLOntologyCreationException;
import org.semanticweb.owlapi.model.OWLOntologyManager;
import org.semanticweb.owlapi.reasoner.structural.StructuralReasonerFactory;

import de.derivo.sparqldlapi.QueryEngine;
import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.event.AddedBeliefEvent;
import ru.agentlab.maia.event.RemovedBeliefEvent;

public class BeliefBase implements IBeliefBase {

	@Inject
	OWLOntologyManager manager;

	@Inject
	OWLDataFactory factory;

	private final Queue<IEvent<?>> eventQueue;

	private final IRI ontologyIRI;

	OWLOntology ontology;

	QueryEngine engine;// = QueryEngine.create(manager, (new
						// StructuralReasonerFactory()).createReasoner(ontology),
						// true);

	public BeliefBase(Queue<IEvent<?>> eventQueue, String namespace) {
		this.eventQueue = eventQueue;
		ontologyIRI = IRI.create(namespace);
		try {
			ontology = manager.createOntology(ontologyIRI);
		} catch (OWLOntologyCreationException e) {
			e.printStackTrace();
		}
		engine = QueryEngine.create(manager, (new StructuralReasonerFactory()).createReasoner(ontology), true);
		manager.addOntologyChangeListener(changes -> {
			changes.forEach(change -> {
				if (change.getOntology() == ontology) {
					OWLAxiom axiom = change.getAxiom();
					if (change.isAddAxiom()) {
						this.eventQueue.offer(new AddedBeliefEvent(axiom));
					} else if (change.isRemoveAxiom()) {
						this.eventQueue.offer(new RemovedBeliefEvent(axiom));
					}
				}
			});
		});
	}

	@Override
	public void addBelief(OWLAxiom axiom) {
		manager.addAxiom(ontology, axiom);
	}

	@Override
	public void removeBelief(OWLAxiom axiom) {
		manager.removeAxiom(ontology, axiom);
	}

	@Override
	public boolean containsBelief(OWLAxiom axiom) {
		return ontology.containsAxiom(axiom);
	}

	@Override
	public QueryEngine getQueryEngine() {
		return engine;
	}

	@Override
	public OWLOntologyManager getManager() {
		return manager;
	}

	@Override
	public OWLDataFactory getFactory() {
		return factory;
	}

	@Override
	public IRI getOntologyIRI() {
		return ontologyIRI;
	}

	@Override
	public OWLOntology getOntology() {
		return ontology;
	}

}
