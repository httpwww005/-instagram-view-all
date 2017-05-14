from __future__ import print_function
from bottle import response, request, get, post, route, run, template
import requests

import logging
logger = logging.getLogger()

import os
import sys
import json


class Instagram():
    pattern_url = "https://www.instagram.com/%s/?__a=1%s"
    pattern_maxid = "&max_id=%s"

    def parse_nodes(self, nodes):
        new_nodes = []
        for node in nodes:
            src = node["display_src"]
            w = node["dimensions"]["width"]
            h = node["dimensions"]["height"]
            msrc = node["thumbnail_src"]
            title = node.get("caption", "")

            new_node = {
                    "src":src,
                    "w":w,
                    "h":h,
                    "msrc":msrc,
                    "title":title}

            new_nodes.append(new_node)

        return new_nodes

    def __init__(self, ig_user, total=None):
        self.ig_user = ig_user
        self.base_url = self.pattern_url % (ig_user, "")

        self.nodes = []

        if total:
            self.total = int(total)

        response = self.get_ig()

        media = response["user"]["media"]
        nodes = media["nodes"]
        self.count = media["count"]
        self.has_next_page = media["page_info"]["has_next_page"]
        self.next_id = nodes[-1]["id"]
        self.nodes.extend(self.parse_nodes(nodes))
        self.count = len(nodes)

    def run(self):
        has_next_page = self.has_next_page
        while True:
            #print("current count: %s" % self.count, file=sys.stderr)
            has_next_page = self.has_next_page
            if has_next_page and (self.count < self.total):
                response = self.get_ig(self.next_id)
                media = response["user"]["media"]
                nodes = media["nodes"]
                self.next_id = nodes[-1]["id"]
                self.count += len(nodes)
                self.nodes.extend(self.parse_nodes(nodes))
            else:
                break

        return self.nodes

    def get_ig(self, next_id=None):
        if next_id:
            url = self.base_url + self.pattern_maxid % next_id
            #response = requests.get(next_url).json()
            #print(response, file=sys.stderr)
        else:
            #print(response, file=sys.stderr)
            #nodes = response["user"]["media"]["nodes"]
            #self.nodes.extend(nodes)
            url = self.base_url

        response = requests.get(url).json()
        return response



@route('/')
@route('/<ig_user>')
def index(ig_user=None):
    if ig_user == "favicon.ico":
        return ""

    print(dict(request.query), file=sys.stderr)

    query = dict(request.query)

    total = int(query.get("total", 11))
  
    if "pswp" in query:
        pswp = True
    else:
        pswp = False
        
   

    if ig_user:
        ig = Instagram(ig_user, total=total)
        r = ig.run()

        print(r, file=sys.stderr)

        if pswp:
            response['Content-Type'] = "application/json"
            #return json.dumps({"items":r})
            return json.dumps(r[:total])
        else:
            return template('ig', ig_user = ig_user, total=total) 
    else:
    	return template('index')


port = int(os.environ.get('PORT',5000))
run(host='0.0.0.0', port=port, debug=False, reloader=True)
